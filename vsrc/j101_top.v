`include "j101_defines.v"

module j101_top(
        input   [`J101_RFIDX_WIDTH-1:0] rs1_idx, // rs1 index
        input   [`J101_RFIDX_WIDTH-1:0] rs2_idx, // rs2 index
        output  [`J101_XLEN-1:0]        rs1_dat,
        output  [`J101_XLEN-1:0]        rs2_dat,

        input   wbck_wen,
        input   [`J101_RFIDX_WIDTH-1:0] wbck_idx, // wbck index
        input   [`J101_XLEN-1:0]        wbck_dat,

        input   clk
    );

    j101_regfile u_j101_regfile(
                     .read_src1_idx (rs1_idx),
                     .read_src2_idx (rs2_idx),
                     .read_src1_dat (rs1_dat),
                     .read_src2_dat (rs2_dat),

                     .wbck_dest_wen (wbck_wen),
                     .wbck_dest_idx (wbck_idx),
                     .wbck_dest_dat (wbck_dat),

                     .clk           (clk)
                 );

endmodule
