`timescale 1 ns / 1 ns

module kna6034201 (
	input clock,			// Pin 18.
	
	input [2:0] SH,
	
	input [7:0] byte_1,	// Pins 8-1.
	input [7:0] byte_2,	// Pins 16-10.
	input [7:0] byte_3,	// Pins 32-39.
	input [7:0] byte_4,	// Not in original hardware
	
	output bit_1,		// Pin 31.
	output bit_1r,		// Pin 30.
	
	output bit_2,		// Pin 29.
	output bit_2r,		// Pin 28.
	
	output bit_3,		// Pin 27.
	output bit_3r,		// Pin 26.
	
	output bit_4,			// Not in original hardware
	output bit_4r
);


reg [7:0] shift_reg_1;	// Eagle - IC1.
reg [7:0] shift_reg_2;	// Eagle - IC2.
reg [7:0] shift_reg_3;	// Eagle - IC3.
reg [7:0] shift_reg_4;	// Eagle - IC4.
reg [7:0] shift_reg_5;	// Eagle - IC5.
reg [7:0] shift_reg_6;	// Eagle - IC6.
reg [7:0] shift_reg_7;
reg [7:0] shift_reg_8;

reg [2:0] old_sh = 0;

always @(posedge clock) begin
	old_sh <= SH;
	if (SH == 3'b000) begin
		shift_reg_1 <= byte_1;
		shift_reg_2 <= {byte_1[0],byte_1[1],byte_1[2],byte_1[3],byte_1[4],byte_1[5],byte_1[6],byte_1[7]};

		shift_reg_3 <= byte_2;
		shift_reg_4 <= {byte_2[0],byte_2[1],byte_2[2],byte_2[3],byte_2[4],byte_2[5],byte_2[6],byte_2[7]};

		shift_reg_5 <= byte_3;
		shift_reg_6 <= {byte_3[0],byte_3[1],byte_3[2],byte_3[3],byte_3[4],byte_3[5],byte_3[6],byte_3[7]};

		shift_reg_7 <= byte_4;
		shift_reg_8 <= {byte_4[0],byte_4[1],byte_4[2],byte_4[3],byte_4[4],byte_4[5],byte_4[6],byte_4[7]};
	end
	else if (SH != old_sh) begin
		shift_reg_1 <= {shift_reg_1[6:0],1'b0};	// Shift out, MSB first.
		shift_reg_2 <= {shift_reg_2[6:0],1'b0};	// Shift out, MSB first.
		
		shift_reg_3 <= {shift_reg_3[6:0],1'b0};	// Shift out, MSB first.
		shift_reg_4 <= {shift_reg_4[6:0],1'b0};	// Shift out, MSB first.
		
		shift_reg_5 <= {shift_reg_5[6:0],1'b0};	// Shift out, MSB first.
		shift_reg_6 <= {shift_reg_6[6:0],1'b0};	// Shift out, MSB first.

		shift_reg_7 <= {shift_reg_7[6:0],1'b0};	// Shift out, MSB first.
		shift_reg_8 <= {shift_reg_8[6:0],1'b0};	// Shift out, MSB first.
	end
end

assign bit_1 = shift_reg_1[7];
assign bit_1r = shift_reg_2[7];
assign bit_2 = shift_reg_3[7];
assign bit_2r = shift_reg_4[7];
assign bit_3 = shift_reg_5[7];
assign bit_3r = shift_reg_6[7];
assign bit_4 = shift_reg_7[7];
assign bit_4r = shift_reg_8[7];

endmodule
