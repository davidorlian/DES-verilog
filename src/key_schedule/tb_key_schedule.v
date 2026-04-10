module tb_key_schedule;

    reg  [63:0] key_in;
    wire [47:0] round_key0, round_key1, round_key2, round_key3;
    wire [47:0] round_key4, round_key5, round_key6, round_key7;
    wire [47:0] round_key8, round_key9, round_key10, round_key11;
    wire [47:0] round_key12, round_key13, round_key14, round_key15;

    key_schedule uut (
        .key_in(key_in),
        .round_key0(round_key0),   .round_key1(round_key1),
        .round_key2(round_key2),   .round_key3(round_key3),
        .round_key4(round_key4),   .round_key5(round_key5),
        .round_key6(round_key6),   .round_key7(round_key7),
        .round_key8(round_key8),   .round_key9(round_key9),
        .round_key10(round_key10), .round_key11(round_key11),
        .round_key12(round_key12), .round_key13(round_key13),
        .round_key14(round_key14), .round_key15(round_key15)
    );

    reg [47:0] expected_keys [0:15];

    initial begin
        key_in = 64'h0123456789ABCDEF;

        expected_keys[0]  = 48'h0B02679B49A5;
        expected_keys[1]  = 48'h69A659256A26;
        expected_keys[2]  = 48'h45D48AB428D2;
        expected_keys[3]  = 48'h7289D2A58257;
        expected_keys[4]  = 48'h3CE80317A6C2;
        expected_keys[5]  = 48'h23251E3C8545;
        expected_keys[6]  = 48'h6C04950AE4C6;
        expected_keys[7]  = 48'h5788386CE581;
        expected_keys[8]  = 48'hC0C9E926B839;
        expected_keys[9]  = 48'h91E307631D72;
        expected_keys[10] = 48'h211F830D893A;
        expected_keys[11] = 48'h7130E5455C54;
        expected_keys[12] = 48'h91C4D04980FC;
        expected_keys[13] = 48'h5443B681DC8D;
        expected_keys[14] = 48'hB691050A16B5;
        expected_keys[15] = 48'hCA3D03B87032;

        #5; // Wait for logic to propagate

        $display("---- Testing Key Schedule Output ----");
        $display("Initial key: %016h", key_in);

        check_key(0, round_key0);
        check_key(1, round_key1);
        check_key(2, round_key2);
        check_key(3, round_key3);
        check_key(4, round_key4);
        check_key(5, round_key5);
        check_key(6, round_key6);
        check_key(7, round_key7);
        check_key(8, round_key8);
        check_key(9, round_key9);
        check_key(10, round_key10);
        check_key(11, round_key11);
        check_key(12, round_key12);      
        check_key(13, round_key13);
        check_key(14, round_key14);
        check_key(15, round_key15);

        $display("All tests done.");
        $finish;
    end

    task check_key(input integer i, input [47:0] key);
        begin
            if (key === expected_keys[i]) begin
                $display("Round Key %02d Passed: %012h", i + 1, key);
            end else begin
                $display("Round Key %02d Failed", i + 1);
                $display("  Expected: %012h", expected_keys[i]);
                $display("  Got     : %012h", key);
            end
        end
    endtask

endmodule
