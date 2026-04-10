`timescale 1ns / 1ps

module tb_feistel;

    reg  [63:0] data_in;
    wire [63:0] data_out;

    reg  [47:0] round_key_0;
    reg  [47:0] round_key_1;
    reg  [47:0] round_key_2;
    reg  [47:0] round_key_3;
    reg  [47:0] round_key_4;
    reg  [47:0] round_key_5;
    reg  [47:0] round_key_6;
    reg  [47:0] round_key_7;
    reg  [47:0] round_key_8;
    reg  [47:0] round_key_9;
    reg  [47:0] round_key_10;
    reg  [47:0] round_key_11;
    reg  [47:0] round_key_12;
    reg  [47:0] round_key_13;
    reg  [47:0] round_key_14;
    reg  [47:0] round_key_15;

    // Instantiate the Feistel module
    feistel uut (
        .data_in(data_in),
        .round_key_0(round_key_0),
        .round_key_1(round_key_1),
        .round_key_2(round_key_2),
        .round_key_3(round_key_3),
        .round_key_4(round_key_4),
        .round_key_5(round_key_5),
        .round_key_6(round_key_6),
        .round_key_7(round_key_7),
        .round_key_8(round_key_8),
        .round_key_9(round_key_9),
        .round_key_10(round_key_10),
        .round_key_11(round_key_11),
        .round_key_12(round_key_12),
        .round_key_13(round_key_13),
        .round_key_14(round_key_14),
        .round_key_15(round_key_15),
        .data_out(data_out)
    );

    initial begin
      $display("---- Feistel Test ----");

      data_in = 64'h0000999988887777;

      round_key_1 = 48'hB0BA22D5A390;
      round_key_2 = 48'hA0365631064D;
      round_key_3 = 48'h6456545AB086;
      round_key_0 = 48'hF09A22C103D2;
      round_key_4 = 48'h46D1702465AD;
      round_key_5 = 48'h8EC1732A38C3;
      round_key_6 = 48'hAF430BE6C133;
      round_key_7 = 48'h2B1389070F4A;
      round_key_8 = 48'h3B10C9441752;
      round_key_9 = 48'h1948D8DD806C;
      round_key_10 = 48'h14699C40DEC8;
      round_key_11 = 48'h162D0518B43D;
      round_key_12 = 48'h4B2C25AB5CA0;
      round_key_13 = 48'hC9A4AC086B33;
      round_key_14 = 48'hD086AAB74814;
      round_key_15 = 48'hF08AA2830A56;

      #10;

      $display("Plaintext: %h", data_in);
      $display("IP Out: %h", uut.ip_out);

      $display("Feistel Round Outputs:");
      $display("Round  1: %h", uut.round_data[1]);
      $display("Round  2: %h", uut.round_data[2]);
      $display("Round  3: %h", uut.round_data[3]);
      $display("Round  4: %h", uut.round_data[4]);
      $display("Round  5: %h", uut.round_data[5]);
      $display("Round  6: %h", uut.round_data[6]);
      $display("Round  7: %h", uut.round_data[7]);
      $display("Round  8: %h", uut.round_data[8]);
      $display("Round  9: %h", uut.round_data[9]);
      $display("Round 10: %h", uut.round_data[10]);
      $display("Round 11: %h", uut.round_data[11]);
      $display("Round 12: %h", uut.round_data[12]);
      $display("Round 13: %h", uut.round_data[13]);
      $display("Round 14: %h", uut.round_data[14]);
      $display("Round 15: %h", uut.round_data[15]);
      $display("Round 16: %h", uut.round_data[16]);

      $display("Ciphertext: %h", data_out);

      $finish;
    end

endmodule
