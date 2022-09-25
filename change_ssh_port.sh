# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    change_ssh_port.sh                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pharbst <pharbst@student.42heilbronn.de    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/25 07:08:31 by pharbst           #+#    #+#              #
#    Updated: 2022/09/25 07:45:51 by pharbst          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

!#/bin/bash

read -p "Wanna change the ssh port?(y/N)" confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
read -p "which port u wanna use for ssh?" sshport
echo "you wanna change ssh port to $sshport and also open the port in the firewall UFW if u use another firewall change the script if u dont use a firewall u can continue"
read -p "Continue? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
sudo sed -i "s/.*Port .*/Port $sshport/" /etc/ssh/sshd_config >&-
sudo ufw allow $sshport
echo "if the followed output is correct eveything worked properly"
grep -F "Port " /etc/ssh/sshd_config
sudo ufw status numbered | grep "$sshport"
echo Done