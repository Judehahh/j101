#include "Vj101_top.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <cassert>

VerilatedContext *contextp = NULL;
VerilatedVcdC *tfp = NULL;

static Vj101_top *top;

void step_and_dump_wave() {
  top->eval();
  contextp->timeInc(1);
  tfp->dump(contextp->time());
}

void sim_init() {
  contextp = new VerilatedContext;
  tfp = new VerilatedVcdC;
  top = new Vj101_top;
  contextp->traceEverOn(true);
  top->trace(tfp, 0);
  tfp->open("dump.vcd");
}

void sim_exit() {
  step_and_dump_wave();
  tfp->close();
}

void test_x0() {
  top->clk = 0;
  step_and_dump_wave();

  top->clk = 1;
  top->rs1_idx = 0;
  step_and_dump_wave();
  assert(top->rs1_dat == 0);

  top->clk = 0;
  step_and_dump_wave();

  top->clk = 1;
  top->wbck_wen = 1;
  top->wbck_idx = 0;
  top->wbck_dat = 0xdeadbeef;
  step_and_dump_wave();

  top->clk = 0;
  step_and_dump_wave();

  top->clk = 1;
  top->wbck_wen = 0;
  top->rs1_idx = 0;
  step_and_dump_wave();
  assert(top->rs1_dat == 0);
}

void test_rw() {
  for (int i = 1; i < 32; i++) {
    top->clk = 0;
    step_and_dump_wave();

    top->clk = 1;
    top->wbck_wen = 1;
    top->wbck_idx = i;
    top->wbck_dat = 0xdeadbeef;
    step_and_dump_wave();

    top->clk = 0;
    step_and_dump_wave();

    top->clk = 1;
    top->wbck_wen = 0;
    top->rs1_idx = i;
    step_and_dump_wave();
    assert(top->rs1_dat == 0xdeadbeef);
  }
}

int main() {
  sim_init();

  test_x0();
  test_rw();

  sim_exit();
}
