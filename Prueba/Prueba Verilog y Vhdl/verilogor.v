//======================================================================
// --------
// Test file including an OR function using VERILOG.
//
//======================================================================

module verilogor(
              // two OR inputs.
              input wire           bit0,				// Entrada 0 para el módulo de OR
              input wire           bit1,				// Entrada 1 para el módulo de OR
              // Data ports.
              output wire          outbit				// Salida de la operación OR
             );

  //----------------------------------------------------------------
  assign outbit     = bit0 | bit1;						// Operación OR
  
  endmodule
// End verilogor.v
//======================================================================



