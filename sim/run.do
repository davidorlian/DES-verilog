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
vlog Register/register64.v

vlog key_schedule/pc1/pc1.v
vlog key_schedule/shift/key_round_step.v
vlog key_schedule/pc2/pc2.v
vlog key_schedule/key_schedule.v

vlog feistel/IP_and_inv_IP/ip.v
vlog feistel/IP_and_inv_IP/inv_ip.v

vlog feistel/logic/F_function/E-perm/E_func.v
vlog feistel/logic/F_function/P-perm/P_func.v

vlog feistel/logic/F_function/S-box/sbox1.v
vlog feistel/logic/F_function/S-box/sbox2.v
vlog feistel/logic/F_function/S-box/sbox3.v
vlog feistel/logic/F_function/S-box/sbox4.v
vlog feistel/logic/F_function/S-box/sbox5.v
vlog feistel/logic/F_function/S-box/sbox6.v
vlog feistel/logic/F_function/S-box/sbox7.v
vlog feistel/logic/F_function/S-box/sbox8.v
vlog feistel/logic/F_function/S-box/sbox_layer.v

vlog feistel/logic/F_function/f_function.v
vlog feistel/logic/round_logic.v
vlog feistel/feistel.v

# Top + main TB
vlog des_top.v
vlog tb_des_top.v

# Run
vsim -c work.tb_des_top
run -all
quit -f
