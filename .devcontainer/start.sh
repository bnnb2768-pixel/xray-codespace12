#!/bin/bash

sudo apt update
sudo apt install -y curl unzip

mkdir -p ~/xray
cd ~/xray

curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip

unzip -o xray.zip
chmod +x xray

cat > config.json <<EOF
{
  "log": {
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "port": 8080,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "11111111-1111-1111-1111-111111111111"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws"
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF

./xray run -config config.json
