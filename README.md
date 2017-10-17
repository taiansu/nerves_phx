# NervesPhx

Nerves Phoenix 1.3 template with wireless network and sqlite database

## Setup

1. Clone the project
2. Change to the `nerves_phx/firmware` directory
3. Specify the target with the `MIX_TARGET`
4. Specify wireless network __ssid__ and __psk__
5. Get the dependencies
6. Create a firmware
7. Burn the firmware to an SD card
8. Insert the SD card into your target board and power it on

```shell
git clone git@github.com:taiansu/nerves_phx.git
cd nerves_phx/firmware
export MIX_TARGET=rpi3
export NERVES_NETWORK_SSID=your_accesspoint_name
export NERVES_NETWORK_PSK=secret
mix deps.get
mix firmware
mix firmware.burn
```
