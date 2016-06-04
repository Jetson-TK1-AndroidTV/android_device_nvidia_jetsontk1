#!/system/bin/sh
mkdir /dev/dvb
chmod 777 /dev/dvb
chmod 777 /dev/dvb0.frontend0
chmod 777 /dev/dvb0.demux0
chmod 777 /dev/dvb0.dvr0
chmod 777 /dev/dvb0.net0

mkdir /dev/dvb/adapter0
ln -s /dev/dvb0.frontend0 /dev/dvb/adapter0/frontend0
ln -s /dev/dvb0.demux0 /dev/dvb/adapter0/demux0 
ln -s /dev/dvb0.dvr0 /dev/dvb/adapter0/dvr0
ln -s /dev/dvb0.dvr0 /dev/dvb/adapter0/dvr0.ts
ln -s /dev/dvb0.net0 /dev/dvb/adapter0/net0 
chmod 777 /dev/dvb/adapter0
chmod 777 /dev/dvb/adapter0/frontend0
chmod 777 /dev/dvb/adapter0/demux0
chmod 777 /dev/dvb/adapter0/dvr0
chmod 777 /dev/dvb/adapter0/dvr0.ts
chmod 777 /dev/dvb/adapter0/net0

mkdir /dev/dvb/adapter1
ln -s /dev/dvb1.frontend0 /dev/dvb/adapter1/frontend0
ln -s /dev/dvb1.demux0 /dev/dvb/adapter1/demux0 
ln -s /dev/dvb1.dvr0 /dev/dvb/adapter1/dvr0
ln -s /dev/dvb1.dvr0 /dev/dvb/adapter1/dvr0.ts
ln -s /dev/dvb1.net0 /dev/dvb/adapter1/net0 
chmod 777 /dev/dvb/adapter1
chmod 777 /dev/dvb/adapter1/frontend0
chmod 777 /dev/dvb/adapter1/demux0
chmod 777 /dev/dvb/adapter1/dvr0
chmod 777 /dev/dvb/adapter1/dvr0.ts
chmod 777 /dev/dvb/adapter1/net0

mkdir /dev/dvb/adapter2
ln -s /dev/dvb2.frontend0 /dev/dvb/adapter2/frontend0
ln -s /dev/dvb2.demux0 /dev/dvb/adapter2/demux0 
ln -s /dev/dvb2.dvr0 /dev/dvb/adapter2/dvr0
ln -s /dev/dvb2.dvr0 /dev/dvb/adapter2/dvr0.ts
ln -s /dev/dvb2.net0 /dev/dvb/adapter2/net0 
chmod 777 /dev/dvb/adapter2
chmod 777 /dev/dvb/adapter2/frontend0
chmod 777 /dev/dvb/adapter2/demux0
chmod 777 /dev/dvb/adapter2/dvr0
chmod 777 /dev/dvb/adapter2/dvr0.ts
chmod 777 /dev/dvb/adapter2/net0

/data/dvb/tvheadend -c /data/dvb/hts 2>&1 > /data/dvb/tvheadend.out &
