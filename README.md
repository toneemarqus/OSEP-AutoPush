# OSEP-Auto-Push
This Repostry is created to help OSEP students keep their files safe during the OSEP 3 months course. The main advantages of using this method are:
- Keep you files safe, always backed up in GitHub reposotry.
- Utilise Apache server on Kali with port 80 (which is allowed most of the time and not blocked by Firewalls and Network filters)

## How it works?
When you put/modify any file inside the /var/www/html, it will be directly uploaded using a cronjob script running and checking for chanches every one minute, if change is detected, it will push it online to the GitHub repo.

## Getting started
1. Create new repositry on GitHub and add you SSH public key to your GitHub account so the script can push and pull direclty, you can use:
   - generate SSH keys:
     '''
     ssh-keygen -t ed25519 -C "tony.marqus1994@yahoo.com"
     '''
   - Copy the public key to GitHub:
     '''
     cat ~/.ssh/id_ed25519.pub
     '''
     ![image](https://github.com/user-attachments/assets/fe7ce705-686f-4a01-8806-7090f8035fda)

   - Set your email and username:
     '''
     git config --global user.email "youemail@gmail.com"
     git config --global user.name "Your Name"
     '''
     Now you are ready for the next step.
2. Clone the new reposity and cd to it, copy all files to /var/www/html (including .git) files.
3. Crete new file called run.sh with the code included in this repositry.
4. Add new cronjob to kali as following:
   """
   */1 * * * * /var/www/html/run.sh
   """
