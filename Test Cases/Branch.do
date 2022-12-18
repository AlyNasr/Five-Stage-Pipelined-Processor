add wave sim:/main/*
force -freeze sim:/main/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/main/Reset 1 0
force -freeze sim:/main/Interrupt 0 0
run
force -freeze sim:/main/Reset 0 0
force -freeze sim:/main/InPort 8'h30 0
run
force -freeze sim:/main/InPort 8'h50 0
run
force -freeze sim:/main/InPort 8'h100 0
run
force -freeze sim:/main/InPort 8'h300 0
run
force -freeze sim:/main/InPort 8'hffffffff 0
run
run
run
run
run
run
run
force -freeze sim:/main/Interrupt 1 0
run
force -freeze sim:/main/Interrupt 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/main/InPort 8'h200 0
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/main/Interrupt 1 0
run
force -freeze sim:/main/Interrupt 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run


