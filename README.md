<img alt="Nvidia Jetson TK1" src="http://quickreachmedia.sytes.net/pics/nvidia-jetson-tk1.jpg" />

#About Tegra K1

Tegra K1 is NVIDIA's first mobile processor to have the same advanced features & architecture as a modern desktop GPU while still using the low power draw of a mobile chip. Therefore Tegra K1 allows embedded devices to use the exact same CUDA code that would also run on a desktop GPU (used by over 100,000 developers), with similar levels of GPU-accelerated performance as a desktop.

#About Jetson TK1

Jetson TK1 dev board
Jetson TK1 is NVIDIA's embedded Linux development platform featuring a Tegra K1 SOC (CPU+GPU+ISP in a single chip), selling for $192 USD. Jetson TK1 comes pre-installed with Linux4Tegra OS (basically Ubuntu 14.04 with pre-configured drivers). There is also some official support for running other distributions using the mainline kernel.

Besides the quad-core 2.3GHz ARM Cortex-A15 CPU and the revolutionary Tegra K1 GPU, the Jetson TK1 board includes similar features as a Raspberry Pi but also some PC-oriented features such as SATA, mini-PCIe and a fan to allow continuous operation under heavy workloads:

Hardware Features
Dimensions: 5" x 5" (127mm x 127mm) board
Tegra K1 SOC (CPU+GPU+ISP in a single chip, with typical power consumption between 1 to 5 Watts):
GPU: NVIDIA Kepler "GK20a" GPU with 192 SM3.2 CUDA cores (upto 326 GFLOPS)
CPU: NVIDIA "4-Plus-1" 2.32GHz ARM quad-core Cortex-A15 CPU with Cortex-A15 battery-saving shadow-core
DRAM: 2GB DDR3L 933MHz EMC x16 using 64-bit data width
Storage: 16GB fast eMMC 4.51 (routed to SDMMC4)
mini-PCIe: a half-height single-lane PEX slot (such as for Wifi, SSD RAID, FireWire or Ethernet addon cards)
SD/MMC card: a full-size slot (routed to SDMMC3)
USB 3.0: a full-size Type-A female socket
USB 2.0: a micro-AB female socket (for connecting to a PC, but can also be used as a spare USB 2.0 port using a micro-B male to female Type-A adapter that is sometimes included)
HDMI: a full-size port
RS232: a full-size DB9 serial port (routed to UART4)
Audio: an ALC5639 Realtek HD Audio codec with Mic in and Line out jacks (routed to DAP2)
Ethernet: a RTL8111GS Realtek 10/100/1000Base-T Gigabit LAN port using PEX
SATA: a full-size port that supports 2.5" and 3.5" disks, but is not hot-pluggable. (Turn off the power before plugging in SATA disk drives)
JTAG: a 2x10-pin 0.1" port for professional debugging
Power: a 12V DC barrel power jack and a 4-pin PC IDE power connector, using AS3722 PMIC
Fan: a fan-heatsink running on 12V (to allow safely running intense workloads continuously, but can usually be replaced by a heat-spreader or heatsink)
The following signals are available through the 125-pin 2mm-pitch expansion port:

Camera ports: 2 fast CSI-2 MIPI camera ports (one 4-lane and one 1-lane)
LCD port: LVDS and eDP Display Panel
Touchscreen ports: Touch SPI 1 x 4-lane + 1 x 1-lane CSI-2
UART
HSIC
I2C: 3 ports
GPIO: 7 x GPIO pins (1.8V). Camera CSI pins can also be used for extra GPIO if you don't use both cameras.
Front panel connector:

Green - Power LED
Orange - HDD LED
Red - Power Button
Purple / Blue - Reset Button
Hardware-accelerated APIs supported:

CUDA 6.0 (SM3.2, roughly the same as desktop SM3.5)
OpenGL 4.4
OpenGL ES 3.1
OpenMAX IL multimedia codec including H.264, VC-1 and VP8 through Gstreamer
NPP (CUDA optimized NVIDIA Performance Primitives)
OpenCV4Tegra (NEON + GLSL + quad-core CPU optimizations)
VisionWorks

