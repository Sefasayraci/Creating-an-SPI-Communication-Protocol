@echo off
set xv_path=C:\\Xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xelab  -wto 33608245ef9048c9ac13f4c834f9c186 -m64 --debug typical --relax -L xil_defaultlib -L secureip --snapshot spi_master_slave_behav xil_defaultlib.spi_master_slave -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
