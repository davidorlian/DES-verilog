# run_des_top.do
# Compile + run the main DES flow (des_top + tb_des_top) in ModelSim/Questa.

transcript on

# Create and map work library
if {[file exists work]} {
  vdel -lib work -all
}
vlib work
vmap work work

# Compile RTL (order kept explicit for stability)
vlog src/Register/register64.v

vlog src/key_schedule/pc1/pc1.v
vlog src/key_schedule/shift/key_round_step.v
vlog src/key_schedule/pc2/pc2.v
vlog src/key_schedule/key_schedule.v

vlog src/feistel/IP_and_inv_IP/ip.v
vlog src/feistel/IP_and_inv_IP/inv_ip.v

vlog src/feistel/logic/f_function/e_permutation/e_permutation.v
vlog src/feistel/logic/F_function/P-perm/P_func.v

vlog src/feistel/logic/F_function/S-box/sbox1.v
vlog src/feistel/logic/F_function/S-box/sbox2.v
vlog src/feistel/logic/F_function/S-box/sbox3.v
vlog src/feistel/logic/F_function/S-box/sbox4.v
vlog src/feistel/logic/F_function/S-box/sbox5.v
vlog src/feistel/logic/F_function/S-box/sbox6.v
vlog src/feistel/logic/F_function/S-box/sbox7.v
vlog src/feistel/logic/F_function/S-box/sbox8.v
vlog src/feistel/logic/F_function/S-box/sbox_layer.v

vlog src/feistel/logic/F_function/f_function.v
vlog src/feistel/logic/round_logic.v
vlog src/feistel/feistel.v

# Top + main TB
vlog src/des_top.v
vlog tb/tb_des_top.v

# Run
vsim work.tb_des_top
log -r /*
add wave -r /*
run -all
quit -f
