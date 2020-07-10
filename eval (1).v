`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2020 11:55:18 AM
// Design Name: 
// Module Name: metric
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

	module rom_memory(address, data);
	
		input [3:0] address;
		output [7:0] data;
	
		assign data = 	(address == 4'd0)	?	8'd57:
						(address == 8'd1)	?	8'd61:
						(address == 8'd2)	?	8'd22:
						(address == 8'd3)	?	8'd98:
						(address == 8'd4)	?	8'd121:
						(address == 8'd5)	?	8'd17:
						(address == 8'd6)	?	8'd13:
												8'd3;
	endmodule


	module eval_module(clk, rst, data_in1, data_in2, result, kernel_enable);
	
		input clk, rst;
	
		input [7:0]	data_in1;
		input [7:0]	data_in2;
		
		input kernel_enable;
	
		output reg [7:0] result;
	
		wire [3:0] address =	data_in1[3:0];
		
		wire [7:0] rom_out;
		wire [7:0] flipped = 	~(data_in2);
		reg [7:0] flipreg;
		reg [7:0] romout;
		reg [7:0] r1;
		reg [7:0] r2;
		reg [7:0] r3;
		reg [7:0] r4;
		reg [7:0] r5;
		wire clk2=clk&kernel_enable;
		reg [7:0] r6;

//		
		
	
		rom_memory rom(.address(address),.data(rom_out));
	
		always@(posedge clk)
		begin

		    
		    
		    r4<=data_in1;
		    r5<=r4;
		    flipreg<=flipped;
		    r6<=flipreg;
            r3<=r6 + r5;

		end
		always@(posedge clk2)
		begin
		romout<=rom_out;
		r1<=romout + flipreg;
		r2<=r1 + r5;
		end
		always@(posedge clk)
		begin
		if(rst)
			begin
				result <=	8'd0;
			end
			else
			begin
				if(kernel_enable)
					result <=	r2;
				else	
					result <=	r3;
			end
		end
		
	
	endmodule
