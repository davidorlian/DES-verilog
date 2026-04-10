module tb_key_round_step;

    reg  [55:0] in_key;
    reg  [1:0]  shift_amount;
    wire [55:0] shifted_key;

    // Instantiate the module under test
    key_round_step uut (
        .in_key(in_key),
        .shift_amount(shift_amount),
        .shifted_key(shifted_key)
    );

    // Test vectors
    reg [55:0] test_keys     [0:2];
    reg [1:0]  shift_values  [0:2];
    reg [55:0] expected_outs [0:2];

    integer i;

    initial begin
        // Test vector 0: No shift
        test_keys[0]     = 56'hABCDEF12345678;
        shift_values[0]  = 2'd0;
        expected_outs[0] = 56'hABCDEF12345678;

        // Test vector 1: Shift by 1
        test_keys[1]     = 56'hABCDEF12345678;
        shift_values[1]  = 2'd1;
        expected_outs[1] = {test_keys[1][54:28], test_keys[1][55], test_keys[1][26:0], test_keys[1][27]};

        // Test vector 2: Shift by 2
        test_keys[2]     = 56'hABCDEF12345678;
        shift_values[2]  = 2'd2;
        expected_outs[2] = {test_keys[2][53:28], test_keys[2][55:54], test_keys[2][25:0], test_keys[2][27:26]};

        for (i = 0; i < 3; i = i + 1) begin
            in_key       = test_keys[i];
            shift_amount = shift_values[i];
            #1;
            if (shifted_key === expected_outs[i]) begin
                $display("Test %0d Passed", i+1);
            end else begin
                $display("Test %0d Failed", i+1);
                $display("  Input         : %014h", test_keys[i]);
                $display("  Shift Amount  : %0d", shift_values[i]);
                $display("  Expected      : %014h", expected_outs[i]);
                $display("  Got           : %014h", shifted_key);
            end
        end

        $display("All tests completed.");
        $finish;
    end

endmodule
