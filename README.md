# OSEP-Auto-Push

An automated GitHub backup solution for OSEP course materials, leveraging Apache's web server for reliable file synchronization.

## Overview

OSEP-Auto-Push provides automatic backup functionality for OSEP students during their 3-month course period. It utilizes Apache's web server directory (`/var/www/html`) to detect and sync file changes to GitHub, ensuring your work remains safely backed up.

### Key Benefits

- Automatic backup of course materials to GitHub
- Leverages Apache server on port 80, which typically bypasses firewall restrictions
- Minimal setup required with automated synchronization
- Real-time backup with minute-by-minute monitoring

## Installation

### Prerequisites

- GitHub account with SSH access configured
- Apache web server installed on Kali Linux
- Basic understanding of Git and cron jobs

### SSH Key Setup

1. Generate a new SSH key:
```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
```

2. Add the public key to your GitHub account:
```bash
cat ~/.ssh/id_ed25519.pub
```

3. Configure Git globally:
```bash
git config --global user.email "your.email@example.com"
git config --global user.name "Your Name"
```

### Repository Setup

1. Create a new repository on GitHub
2. Clone your repository and set up the web directory:
```bash
git clone git@github.com:username/repo-name.git
cp -r repo-name/* /var/www/html/
cp -r repo-name/.git /var/www/html/
```

### Automation Setup

1. Create the automation script:
```bash
cp run.sh /var/www/html/
chmod +x /var/www/html/run.sh
```

2. Add the cron job for automatic synchronization:
```bash
(crontab -l 2>/dev/null; echo "*/1 * * * * /var/www/html/run.sh") | crontab -
```

## Usage

1. Place your OSEP course files in `/var/www/html/`
2. Files will automatically sync to GitHub every minute when changes are detected
3. Monitor your GitHub repository for successful pushes

## Contributing

Contributions are welcome! Please feel free to submit pull requests or create issues for any improvements.

## Security Notice

Remember to:
- Never store sensitive credentials in your repository
- Regularly verify your backups on GitHub
- Monitor the synchronization logs for any issues

## License

This project is open source and available under the MIT License.
