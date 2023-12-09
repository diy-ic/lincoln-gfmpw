// may or may not work
// issue open since nov 30 2022
// https://github.com/google/gf180mcu-pdk/issues/101

module \$_DLATCH_P_ (input E, input D, output Q);
  gf180mcu_fd_sc_mcu7t5v0__latq_1 _TECHMAP_DLATCH_P (
    .D(D),
    .Q(Q),
    .GATE(E)
  );
endmodule

module \$_DLATCH_N_ (input E, input D, output Q);
  gf180mcu_fd_sc_mcu7t5v0__latrnq_1 _TECHMAP_DLATCH_N (
    .D(D),
    .Q(Q),
    .GATE_N(E)
  );
endmodule