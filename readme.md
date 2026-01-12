## CRONTAB CHECK DATABASE STATUS

Date: 2026-01-12

### Situation

- 資料庫服務不知原因會出現 OOM(out of memor)的保護機制問題
- 只是需要人工開啟就好，因此設定自動排程檢查來解決問題

### AIM:

- 檢查 MariaDB 和 MySQL 的狀態
- 設定排程來檢查與重啟服務
- 將狀況寫入 LOG FILE 中，已被後續所需

### HOW TO USE:

    1. 將 check_db.sh 拷貝到 /usr/local/bin/
    2. 設定 crontab
    3. 重啟 crontab

### PROCESS:

- 將 check_db.sh 拷貝到 /usr/local/bin/
- 輸入 crontab -e

> \* \* \* \* \* /usr/local/bin/check_db.sh

#### 設定時程

可參考 refer: https://linux.vbird.org/linux_basic/centos7/0430cron.php#whatiscron_type
**對應格式: 分鐘 小時 日 月 星期**

\* 5-7 \* \* \* /usr/local/bin/check_db.sh

因為我需要針對 5-7 這個時間段進行檢查，所以設定為
這樣每天的 5-7 都會執行一次 check_db.sh

#### 重啟 crontab

> systemctl restart crond

#### 查看 crontab 狀態

> crontab -l
