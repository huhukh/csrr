#!/bin/bash

# Mengunduh skrip awal dan memberikan izin eksekusi
wget -O ng.sh https://github.com/kmille36/Docker-Ubuntu-Desktop-NoMachine/raw/main/ngrok.sh > /dev/null 2>&1
chmod +x ng.sh
./ng.sh

# Fungsi untuk menginstal Google Chrome
function install_chrome {
    echo "Menambahkan repositori Google Chrome..."
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
    sudo apt-get update
    sudo apt-get install -y google-chrome-stable
}

# Fungsi untuk menghapus Firefox jika ada
function remove_firefox {
    if dpkg -l | grep -q firefox; then
        echo "Menghapus Firefox..."
        sudo apt-get remove --purge -y firefox
        sudo apt-get autoremove -y
    fi
}

# Fungsi untuk membuka Google Chrome dengan 25 tab acak dari daftar video YouTube
function open_chrome_with_random_tabs {
    echo "Membuka Google Chrome dengan 25 tab YouTube secara acak..."

    # Daftar URL video YouTube
    video_urls=(
        "https://www.youtube.com/watch?v=WSx7upUpjFw&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A"
        "https://www.youtube.com/watch?v=AUIsWceCj3I&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=4"
        "https://www.youtube.com/watch?v=IaY2nZKj4_M&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=2"
        "https://www.youtube.com/watch?v=GIMt_A7N8bU&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=3"
        "https://www.youtube.com/watch?v=FAKnaKPCu8s&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=6"
        "https://www.youtube.com/watch?v=yg1JbJJmNyc&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=5"
        "https://www.youtube.com/watch?v=MjRvD_LS6_g&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=8"
        "https://www.youtube.com/watch?v=QYy869tu0Q8&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=7"
        "https://www.youtube.com/watch?v=nJpJy0RWhk4&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=10"
        "https://www.youtube.com/watch?v=tCM6__Y0jpI&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=9"
        "https://www.youtube.com/watch?v=jp4PTo4XLQk&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=12"
        "https://www.youtube.com/watch?v=gNzw5BTkWrg&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=11"
        "https://www.youtube.com/watch?v=yRSenmEX9g4&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=13"
        "https://www.youtube.com/watch?v=XtlTcihyEXA&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=14"
        "https://www.youtube.com/watch?v=B85bOUJV2X4&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=16"
        "https://www.youtube.com/watch?v=kBibiBkEjoI&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=15"
        "https://www.youtube.com/watch?v=2QGQLBaUa28&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=17"
        "https://www.youtube.com/watch?v=bQm8zhG1Tl0&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=18"
        "https://www.youtube.com/watch?v=CHT4j6YMEms&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=20"
        "https://www.youtube.com/watch?v=X_13vNxMIgk&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=19"
        "https://www.youtube.com/watch?v=6UOxNx6wkhU&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=21"
        "https://www.youtube.com/watch?v=AVPCqbvn6kw&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=23"
        "https://www.youtube.com/watch?v=LadowntPscM&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=22"
        "https://www.youtube.com/watch?v=IXd0V0PEn1g&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=24"
        "https://www.youtube.com/watch?v=E6W03Fhfr2Y&list=PLhMa4ndXgkssGw8PFuRsYsAbjdvAPGb8A&index=25"
    )
    
    # Acak URL video
    shuffled_urls=($(shuf -e "${video_urls[@]}"))

    # Buat perintah untuk membuka 25 tab dengan URL acak
    youtube_tabs=$(printf " --new-tab '%s'" "${shuffled_urls[@]:0:25}")

    # Jalankan perintah untuk membuka tab di Google Chrome
    google-chrome-stable $youtube_tabs &
}

# Fungsi untuk berpindah ke label tertentu (fungsi yang ada dalam skrip asli Anda)
function goto {
    label=$1
    cd 
    cmd=$(sed -n "/^:[[:blank:]][[:blank:]]*${label}/{:a;n;p;ba};" $0 | 
          grep -v ':$')
    eval "$cmd"
    exit
}

: ngrok
clear
echo "Go to: https://dashboard.ngrok.com/get-started/your-authtoken"
read -p "Paste Ngrok Authtoken: " CRP
./ngrok config add-authtoken $CRP 
clear
echo "Repo: https://github.com/kmille36/Docker-Ubuntu-Desktop-NoMachine"
echo "======================="
echo "choose ngrok region (for better connection)."
echo "======================="
echo "us - United States (Ohio)"
echo "eu - Europe (Frankfurt)"
echo "ap - Asia/Pacific (Singapore)"
echo "au - Australia (Sydney)"
echo "sa - South America (Sao Paulo)"
echo "jp - Japan (Tokyo)"
echo "in - India (Mumbai)"
read -p "choose ngrok region: " CRP
./ngrok tcp --region $CRP 4000 &>/dev/null &
sleep 1
if curl --silent --show-error http://127.0.0.1:4040/api/tunnels  > /dev/null 2>&1; then echo OK; else echo "Ngrok Error! Please try again!" && sleep 1 && goto ngrok; fi
docker run --rm -d --network host --privileged --name nomachine-xfce4 -e PASSWORD=123456 -e USER=user --cap-add=SYS_PTRACE --shm-size=1g thuonghai2711/nomachine-ubuntu-desktop:windows10
clear
echo "NoMachine: https://www.nomachine.com/download"
echo
