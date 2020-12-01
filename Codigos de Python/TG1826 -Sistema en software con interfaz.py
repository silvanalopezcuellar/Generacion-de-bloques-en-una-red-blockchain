#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#=======================================================================
#
# sha256.py
# ---------
# Simple, pure Python model of the SHA-256 hash function. Used as a
# reference for the HW implementation. The code follows the structure
# of the HW implementation as much as possible.
#
#
# Author: Joachim Strömbergson
# Copyright (c) 2013 Secworks Sweden AB
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or
# without modification, are permitted provided that the following
# conditions are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in
#    the documentation and/or other materials provided with the
#    distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#=======================================================================

#-------------------------------------------------------------------
# Python module imports.
#-------------------------------------------------------------------
import serial
import serial.tools.list_ports
import time
import sys
import os
import shutil
import struct
import tkinter as tk

#-------------------------------------------------------------------
# Constants.
#-------------------------------------------------------------------
#arreglohex =[]

VERBOSE = True
HUGE = False
seem = ' '
resultadog = 0
contador = 0
rcontador = 0
bandera = 1


initbyte = b'0'
finalbyte = b'0'

def cerrar():
    global zeronumber, zeroes
    global entrada1,entrada2,ventana, ceros
    texto = entrada1.get()
    ceros = entrada2.get()
    #print(texto)
    #print(ceros)
    archivo = open("pruebaInterfaz.txt","w")
    archivo.write(str((texto)))
    archivo.close()
    cerosint = int(ceros)
    cerosstring = str(ceros)
    zeronumber = cerosint
    zeroes = '0'*zeronumber #Change this variable to generate automatically zeros with zero number
    #print (cerosint)
    #print (cerosstring)
    ventana.destroy()

def interfaz():
    global entrada1,entrada2,ventana
    ventana=tk.Tk()
    ventana.title("Mining System")
    ventana.geometry('680x300')
    ventana.configure(background='thistle')
    el=tk.Label(ventana, text="Insert Block Transactional Contents:", bg="LightPink1", fg="white", font="LARGE_FONT")
    el.pack(padx=10, pady=8, ipadx=10, ipady=10, fill=tk.X)
    entrada1=tk.Entry(ventana)
    entrada1.pack(fill=tk.X, padx=10, pady=10, ipadx=10, ipady=10)
    e2=tk.Label(ventana, text="Insert Zero Quantity [1 2 3 4]:", bg="LightPink1", fg="white", font="LARGE_FONT")
    e2.pack(padx=10, pady=8, ipadx=10, ipady=10, fill=tk.X)
    entrada2=tk.Entry(ventana)
    entrada2.pack(fill=tk.X, padx=10, pady=10, ipadx=10, ipady=10)
    botonminar=tk.Button(ventana,text="MINE", fg="LightPink1", command=cerrar, font="LARGE_FONT")
    botonminar.pack(side=tk.TOP)
    ventana.mainloop()


def padding(archivo):
    global sizestring
    out_filename = archivo +".padded"
    #shutil.copyfile(sys.argv[1], out_filename)
    with open(out_filename,'wb') as f:
        for line in open(archivo):
            line = line.rstrip('\n')
            size = len(line)
            #print(size)
            #f.seek(0, os.SEEK_END)
            #size = f.tell()
            #Add padding word to end of file
            sign = bytearray([0x80])
            #print(sign)

            #Calculate number of padding zeroes
            # = File size rounded up to next 512-byte block
            # minues space for padding start byte (0x80)
            # and 64-bit (8 byte) length word
            zeroes = 64 - (size % 64) - 1 - 8
            if zeroes < 0:
                zeroes += 64
            
            #print(zeroes)
            zerosarray = bytearray([0]*zeroes)
            #sizeword = (size % 64)*8
            #if sizeword == 0:
            #    sizeword = 64*8
            sizeword = (size*8)
            sizestring = struct.pack('>Q', sizeword)
            #print(sizestring)
            total=(sign+zerosarray+sizestring[0:5])
            f.write(line.encode())
            f.write(total)
            f.write(os.linesep.encode())
            #print(total)
    return out_filename


#-------------------------------------------------------------------
# SHA256()
#-------------------------------------------------------------------
class SHA256():
    def __init__(self, mode="sha256", verbose = 0):
        if mode not in ["sha224", "sha256"]:
            print("Error: Given %s is not a supported mode." % mode)
            return 0

        self.mode = mode
        self.verbose = verbose
        self.H = [0] * 8
        self.t1 = 0
        self.t2 = 0
        self.a = 0
        self.b = 0
        self.c = 0
        self.d = 0
        self.e = 0
        self.f = 0
        self.g = 0
        self.h = 0
        self.w = 0
        self.W = [0] * 16
        self.k = 0
        self.K = [0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
                  0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
                  0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
                  0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
                  0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
                  0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
                  0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
                  0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
                  0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
                  0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
                  0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
                  0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
                  0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
                  0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
                  0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
                  0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2]


    def init(self):
        if self.mode == "sha256":
            self.H = [0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
                      0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19]
        else:
            self.H = [0xc1059ed8, 0x367cd507, 0x3070dd17, 0xf70e5939,
                      0xffc00b31, 0x68581511, 0x64f98fa7, 0xbefa4fa4]

    def next(self, block):
        self._W_schedule(block)
        self._copy_digest()
        if self.verbose:
            print("State after init:")
            self._print_state(0)

        for i in range(64):
            self._sha256_round(i)
            if self.verbose:
                self._print_state(i)

        self._update_digest()


    def get_digest(self):
        return self.H


    def _copy_digest(self):
        self.a = self.H[0]
        self.b = self.H[1]
        self.c = self.H[2]
        self.d = self.H[3]
        self.e = self.H[4]
        self.f = self.H[5]
        self.g = self.H[6]
        self.h = self.H[7]


    def _update_digest(self):
        self.H[0] = (self.H[0] + self.a) & 0xffffffff
        self.H[1] = (self.H[1] + self.b) & 0xffffffff
        self.H[2] = (self.H[2] + self.c) & 0xffffffff
        self.H[3] = (self.H[3] + self.d) & 0xffffffff
        self.H[4] = (self.H[4] + self.e) & 0xffffffff
        self.H[5] = (self.H[5] + self.f) & 0xffffffff
        self.H[6] = (self.H[6] + self.g) & 0xffffffff
        self.H[7] = (self.H[7] + self.h) & 0xffffffff


    def _print_state(self, round):
        print("State at round 0x%02x:" % round)
        print("t1 = 0x%08x, t2 = 0x%08x" % (self.t1, self.t2))
        print("k  = 0x%08x, w  = 0x%08x" % (self.k, self.w))
        print("a  = 0x%08x, b  = 0x%08x" % (self.a, self.b))
        print("c  = 0x%08x, d  = 0x%08x" % (self.c, self.d))
        print("e  = 0x%08x, f  = 0x%08x" % (self.e, self.f))
        print("g  = 0x%08x, h  = 0x%08x" % (self.g, self.h))
        print("")


    def _sha256_round(self, round):
        self.k = self.K[round]
        self.w = self._next_w(round)
        self.t1 = self._T1(self.e, self.f, self.g, self.h, self.k, self.w)
        self.t2 = self._T2(self.a, self.b, self.c)
        self.h = self.g
        self.g = self.f
        self.f = self.e
        self.e = (self.d + self.t1) & 0xffffffff
        self.d = self.c
        self.c = self.b
        self.b = self.a
        self.a = (self.t1 + self.t2) & 0xffffffff


    def _next_w(self, round):
        if (round < 16):
            return self.W[round]

        else:
            tmp_w = (self._delta1(self.W[14]) +
                     self.W[9] +
                     self._delta0(self.W[1]) +
                     self.W[0]) & 0xffffffff
            for i in range(15):
                self.W[i] = self.W[(i+1)]
            self.W[15] = tmp_w
            return tmp_w


    def _W_schedule(self, block):
        for i in range(16):
            self.W[i] = block[i]


    def _Ch(self, x, y, z):
        return (x & y) ^ (~x & z)


    def _Maj(self, x, y, z):
        return (x & y) ^ (x & z) ^ (y & z)

    def _sigma0(self, x):
        return (self._rotr32(x, 2) ^ self._rotr32(x, 13) ^ self._rotr32(x, 22))


    def _sigma1(self, x):
        return (self._rotr32(x, 6) ^ self._rotr32(x, 11) ^ self._rotr32(x, 25))


    def _delta0(self, x):
        return (self._rotr32(x, 7) ^ self._rotr32(x, 18) ^ self._shr32(x, 3))


    def _delta1(self, x):
        return (self._rotr32(x, 17) ^ self._rotr32(x, 19) ^ self._shr32(x, 10))


    def _T1(self, e, f, g, h, k, w):
        return (h + self._sigma1(e) + self._Ch(e, f, g) + k + w) & 0xffffffff


    def _T2(self, a, b, c):
        return (self._sigma0(a) + self._Maj(a, b, c)) & 0xffffffff


    def _rotr32(self, n, r):
        return ((n >> r) | (n << (32 - r))) & 0xffffffff


    def _shr32(self, n, r):
        return (n >> r)


#-------------------------------------------------------------------
# print_digest()
#
# Print the given digest.
#-------------------------------------------------------------------
def print_digest(digest, length = 8):
    print("0x%08x, 0x%08x, 0x%08x, 0x%08x" %\
          (digest[0], digest[1], digest[2], digest[3]))
    if length == 8:
        print("0x%08x, 0x%08x, 0x%08x, 0x%08x" %\
            (digest[4], digest[5], digest[6], digest[7]))
    else:
        print("0x%08x, 0x%08x, 0x%08x" %\
            (digest[4], digest[5], digest[6]))
    print("")


#-------------------------------------------------------------------
# compare_digests()
#
# Check that the given digest matches the expected digest.
#-------------------------------------------------------------------
def compare_digests(digest, expected, length = 8):
    correct = True
    for i in range(length):
        if digest[i] != expected[i]:
            correct = False

    if (not correct):
        print("Error:")
        print("Got:")
        print_digest(digest, length)
        print("Expected:")
        print_digest(expected, length)

    else:
        print("Test case ok.")

#-------------------------------------------------------------------
# binario()
#
# Convert a binary into a binary string with an specific size.
#-------------------------------------------------------------------

def binario(numeroin,tamano):
    initbits2 = numeroin[2:]
    answer = initbits2
    if(len(initbits2) != tamano):
        missingzeros = tamano - len(initbits2)
        newcosito = ''
        for i in range (0,missingzeros):
            newcosito += '0'
        answer = newcosito + initbits2
    return(answer)

#-------------------------------------------------------------------
# nonce()
#
# Generate a random number to create a nonce.
#-------------------------------------------------------------------

def nonce():

    global resultadog
    global contador
    global rcontador
    global seem
    global bandera

    #print('seem antes de cuadrado: ',seem)
    cuadrado = int(seem,2)*int(seem,2)
    #print('cuadrado: ',cuadrado)
    #print('cont: ', contador)
    contador+=1
    rcontador+=1
    bincua = bin(cuadrado)
    answerc = binario(bincua,24)
    #print('answercuadrado: ',answerc)
    newseem = answerc[6:18]
    rcontbin = bin(rcontador)
    contanswer = binario(rcontbin,20)
    #print('contador: ',contador)
    resultado = newseem + contanswer
    if (contador == 9 or newseem == '000000000000'):
        #print('contanswer: ',contanswer,' ', int(contanswer,2))
        #print('answerc: ',answerc)
        newseem = contanswer[14] + contanswer[15] + contanswer[16] + contanswer[17] + contanswer[18] + contanswer[19] + seem[0] + seem[1] + seem[2] + seem[3] + seem[4] + seem[5]       #print('newseem: ',newseem,' ', int(newseem,2))
        contador = 0 

    #resultado = newseem + contanswer
    #print('Resultado: ',resultado)
    #print('Resultado en hexa: ', hex(int(resultado,2)))
    seem = newseem
    #print('Seem: ',newseem,' ', int(newseem,2))
    if(rcontador == 1048576):  #Debe ser hasta 1024
        #bandera = 0          ##### Cambiar
        rcontador = 0
    resultadog=hex(int(resultado,2))
    #print('Nonce: ', resultadog)

#-------------------------------------------------------------------
# inputfile()
#
# Gets the inputfile and change it from ascii to binary. Also, includes nonce value.
#-------------------------------------------------------------------

def inputfile(entrada):

    global resultadog, sizestring
    lista = []
    
    for i in range(0, len(entrada), 1):
        numero = hex(ord(entrada[i]))
        if (numero == "0x20ac"):
            lista.append("0x80")
        else:
            lista.append(numero)

    #print(lista)

    listachevere = []
    listacheverep = []
    
    for i in range(0, len(lista)+2, 4):
        if(i == 0):
            numerito = str(resultadog)
        else:
            if(i == (len(lista)-4)):
                numerito = '0x' + (('00' if lista[i-4][2:] == '0' else lista[i-4][2:]) + ('00' if lista[i-3][2:] == '0' else lista[i-3][2:]) + ('00' if lista[i+2][2:] == '0' else lista[i+2][2:]) + ('00' if lista[i + 3][2:] == '0'  else lista[i +3][2:]))
            else:
                numerito = '0x' + (('00' if lista[i-4][2:] == '0' else lista[i-4][2:]) + ('00' if lista[i-3][2:] == '0' else lista[i-3][2:]) + ('00' if lista[i-2][2:] == '0' else lista[i-2][2:]) + ('00' if lista[i-1][2:] == '0'  else lista[i-1][2:]))  
        
        if((i+4) == (len(lista)+2)):
            #numeritoint = int(numerito,16)+(32)
            numeritoint = int.from_bytes(sizestring, 'big')+32
        else:
            numeritoint = int(numerito,16)
        listachevere.append(numeritoint)
        listacheverep.append("%08x" % numeritoint)
    #print('Lista chavere: ',listacheverep)
    return(listachevere)

def get_ports():
 
    ports = serial.tools.list_ports.comports()
   
    return ports


def findArduino(portsFound):
    commPort = 'None'
    numConnection = len(portsFound)
   
    for i in range(0,numConnection):
        port = portsFound[i]
        strPort = str(port)
        
        if 'Silicon Labs CP210x USB to UART Bridge' in strPort:
            print('Returning of getPort: ',strPort)
            splitPort = strPort.split(' ')
            commPort = (splitPort[0])
 
    return commPort

def append_hex(a, b):
    sizeof_b = 0

    # get size of b in bits
    while((b >> sizeof_b) > 0):
        sizeof_b += 1

    # align answer to nearest 4 bits (hex digit)
    sizeof_b += sizeof_b % 4

    return (a << sizeof_b) | b


def inserial(entrada, ceros):
    global initbyte, finalbyte
    cerosadri = ceros*4
    if(cerosadri < 10):
        cerosadri1 = '0'+ str(cerosadri)
    else:
        cerosadri1 = (cerosadri)
    cerosadri2 = list(map(int, str(cerosadri1)))
    cerosadri3 = sorted(cerosadri2,reverse=True)
    cerostotal = ''.join(map(str, cerosadri3)) 
    entradatotal = cerostotal + '0000' + entrada
    #print(entradatotal)
    c = str(hex(int.from_bytes(sizestring, 'big')+32))

    data = entradatotal[:-4]
    #print(data[2:]+c)

    arreglo = []
    arreglohex =[]

    for i in range(0, (len(data)+2), 1):
        #print('conteo', i,' ', (len(entradatotal)-4))
        #print('len: ',len(data))
        if((i == (len(data))) or (i == (len(data)+1))):
            if(i == len(data)):
                if(c[-3]=='x'):
                    numero = 0
                else:
                    numero = int(c[-3],16)
            else:
                numero = int(c[-2:],16)
        else:
            numero = ord(data[i])

        if (numero == 8364):
            arreglohex.append(hex(128))
            arreglo.append(128)
        else:
            arreglohex.append(hex(numero))
            arreglo.append(numero)
    #print(arreglohex)        
    values = bytearray(arreglo)
    HWf = open('HW.txt', 'a')
    HWf.write('\n')
    HWf.write(entrada)
    HWf.write('\n')
    for i in range(0,len(arreglo),1):
        escritor = binario(bin(arreglo[i]),8)
        HWf.write('0'+escritor[::-1]+'1')
    foundPorts = get_ports()
    connectPort = findArduino(foundPorts)

    if connectPort != 'None':
        ser = serial.Serial(connectPort, baudrate = 9600, bytesize = serial.EIGHTBITS, stopbits=serial.STOPBITS_ONE, timeout=1, xonxoff=False, rtscts=False, write_timeout=None, dsrdtr=False, inter_byte_timeout=None, exclusive=None)
        print('Connected to ' + connectPort)
        time.sleep(2)
        ser.write(values)
        answer = ser.read(38).hex()
        print('From Serial Port: ', answer) 
        #exit()
    else:
        print('Connection Issue!')
    print('DONE')
    ser.close()
    #answer = '0000000000000000000000000000000000000000000000000000000000000000000000000000'
    initbyte = bin(int(arreglohex[6],16))
    finalbyte = bin(int(arreglohex[-1],16))
    return answer

#-------------------------------------------------------------------
# sha256_tests()
#
# Tests for the SHA256 mode.
#-------------------------------------------------------------------
def sha256_tests():
    global zeronumber, zeroes
    global initbyte, finalbyte
    global resultadog
    global seem, rcontador, contador
    print("Running test cases for SHA256:")
    my_sha256 = SHA256(verbose=0)

    global bandera

    #fileName = sys.argv[1]
    #print(fileName)
    #File_object = open(fileName,"r")   
    #entrada = File_object.read()
    #File_object.close()
    contadorexito = 0
    contadortotal = 0
    contadorfail = 0
    arrayhashsw=[]
    arrayhashhw=[]
    interfaz()

    for line in open(padding('pruebaInterfaz.txt')):
        entrada = line.rstrip('\n')

        fpga = inserial(entrada, zeronumber)
        #fpga = '0000000000000000000000000000000000000000000000000000000000000000000000000000'

    # TC1: NIST testcase with message "abc"
    #print("TC1: Single block message test specified by NIST.")
    #TC1_block = [0x61626380, 0x00000000, 0x00000000, 0x00000000,
    #             0x00000000, 0x00000000, 0x00000000, 0x00000000,
    #             0x00000000, 0x00000000, 0x00000000, 0x00000000,
    #             0x00000000, 0x00000000, 0x00000000, 0x00000018]
        #bytevar= str.encode(entrada,"ascii",errors="replace")

        #binarios = map(bin, bytevar) 
        #binlist = list(binarios)
        #print(binlist)
        #print(arreglohex)
        #initbyte = bin(int(arreglohex[6],16))
        #finalbyte = bin(int(arreglohex[-1],16))
        #print('init', initbyte)
        #print('final', finalbyte)

        answeri = binario(initbyte,8)
        answerf = binario(finalbyte,8)

        seem = answeri[0] + answeri[1] + answeri[2] + answeri[3] + answeri[4] + answeri[5] + answerf[2] + answerf[3] + answerf[4] + answerf[5] + answerf[6] +answerf[7]

        #print('initial seem: ',seem)
        bandera = 1 
        start_time = time.time()
        #os.remove('salida.txt')
        f1 = open('tiempo.txt', 'a')
        f = open('salida.txt', 'a')
        while(bandera == 1):
            nonce()
            my_sha256.init()
            TC1_block = inputfile(entrada)
            #print('mensaje: ',TC1_block)
            for i in range(0,len(TC1_block),16):
                #print(i)
                my_sha256.next(TC1_block[i:i+16])
            my_digest = my_sha256.get_digest()
            #print_digest(my_digest)
            
            puzzle = str("%08x" % my_digest[0])
            #print('puzzle: ',puzzle[0:zeronumber])
            if(puzzle[0:1] == '0' and rcontador>=1):
                bandera = 0
                hashsalida = "%08x" % my_digest[0] + "%08x" % my_digest[1] + "%08x" % my_digest[2] + "%08x" % my_digest[3] + "%08x" % my_digest[4] + "%08x" % my_digest[5] + "%08x" % my_digest[6] + "%08x" % my_digest[7]
                print('Nonce SW: ', resultadog)
                print('Nonce HW: ', '0x',fpga[64:72])
                #print('Hash software: ',hashsalida)
                arrayhashhw.append(fpga[0:64])
                arrayhashsw.append(hashsalida)
                rcontador = 0
                contador = 0
                tiempo = time.time() - start_time
                print('Time SW: %s seconds' % tiempo)
                print('Time HW: %s useconds' % fpga[72:76])
                contadortotal+=1
                if(fpga[0:64] == hashsalida):
                    contadorexito+=1
                    texto= 'Valid result --'
                else:
                    contadorfail+=1
                    texto='Invalid result -- '
                f.write(texto)
                f.write('\nHash SW: ')
                f.write(hashsalida)
                f.write('\nHash HW: ')
                f.write(fpga[0:64])
                f.write('\nNonce SW: ')
                f.write(str(resultadog)[2:])
                f.write('\nNonce HW: ')
                f.write(fpga[64:72])
                f.write('\nTime SW: ')
                f.write(str(tiempo))
                f.write('\nTime HW: ')
                f.write(fpga[72:76])
                f.write('us\n\n')
                f1.write('\nTime SW: ')
                f1.write(str(tiempo))
                f1.write(' Time HW: ')
                f1.write(fpga[72:76])
                f1.write('\n')

        print('Hash SW: ',arrayhashsw)     
        print('Hash HW: ',arrayhashhw)
    f.write('\nNumber of tests: ')
    f.write(str(contadortotal)) 
    f.write(', Successful tests: ')
    f.write(str(contadorexito))
    f.write(', Failed texts: ')
    f.write(str(contadorfail))
    f.write('\n\n\n\n')  
    f.close() 
            
        #print("puzzle: ", puzzle)
    #print('Hash: ', arrayhash)

#-------------------------------------------------------------------
# main()
#
# If executed tests the ChaCha class using known test vectors.
#-------------------------------------------------------------------
def main():
    print("Testing the SHA-256 Python model.")
    print("---------------------------------")

    sha256_tests()


#-------------------------------------------------------------------
# __name__
# Python thingy which allows the file to be run standalone as
# well as parsed from within a Python interpreter.
#-------------------------------------------------------------------
if __name__=="__main__":
    # Run the main function.
    sys.exit(main())

#=======================================================================
# EOF sha256.py
#=======================================================================
