add wave sim:/main/*
force -freeze sim:/main/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/main/Reset 1 0
force -freeze sim:/main/Interrupt 0 0
run
force -freeze sim:/main/Reset 0 0
force -freeze sim:/main/InPort 8'h5 0
run
force -freeze sim:/main/InPort 8'h19 0
run
force -freeze sim:/main/InPort 8'hFFFD 0
run
force -freeze sim:/main/InPort 8'hF320 0
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
run
run