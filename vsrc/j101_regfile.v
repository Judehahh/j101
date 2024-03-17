`include "j101_defines.v"

module j101_regfile (
        input   [`J101_RFIDX_WIDTH-1:0]   read_src1_idx,
        input   [`J101_RFIDX_WIDTH-1:0]   read_src2_idx,
        output  [`J101_XLEN-1:0]          read_src1_dat,
        output  [`J101_XLEN-1:0]          read_src2_dat,

        input   wbck_dest_wen,
        input   [`J101_RFIDX_WIDTH-1:0]   wbck_dest_idx,
        input   [`J101_XLEN-1:0]          wbck_dest_dat,

        input   clk
    );

    reg [`J101_XLEN-1:0] rf [`J101_RFREG_NUM-1:0];

    always @(posedge clk) begin
        rf[0] <= `J101_XLEN'b0;
        if ((wbck_dest_wen) && (wbck_dest_idx != 0)) begin
            rf[wbck_dest_idx] <= wbck_dest_dat;
        end
    end

    assign read_src1_dat = rf[read_src1_idx];
    assign read_src2_dat = rf[read_src2_idx];

endmodule
