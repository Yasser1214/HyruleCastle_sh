#!/bin/bash


#################### Colors display ####################


GREEN='\033[01;32m' 
PURPLE='\033[0;35m'  
RED='\033[0;31m'    
NC='\033[0m'          


#################### Items ####################


potion=30


#################### Link's param ####################


hpl=60
hplmax=60
hpl_last_potion=$((hplmax-potion))
strl=15

link_life_bar () {
	if [ $hpl -eq 60 ]; then 
		l=" IIIIIIIIIIIIIIIIIIIIIIII "
	elif [ $hpl -eq 55 ]; then 
		l=" IIIIIIIIIIIIIIIIIIIIII__ "
	elif [ $hpl -eq 50 ]; then 
		l=" IIIIIIIIIIIIIIIIIIII____ "
	elif [ $hpl -eq 45 ]; then 
		l=" IIIIIIIIIIIIIIIIII______ "
	elif [ $hpl -eq 40 ]; then 
		l=" IIIIIIIIIIIIIIII________ "
	elif [ $hpl -eq 35 ]; then 
		l=" IIIIIIIIIIIIII__________ "
	elif [ $hpl -eq 30 ]; then 
		l=" IIIIIIIIIIII____________ "
	elif [ $hpl -eq 25 ]; then 
		l=" IIIIIIIIII______________ "
	elif [ $hpl -eq 20 ]; then 
		l=" IIIIIIII________________ "
	elif [ $hpl -eq 15 ]; then 
		l=" IIIIII__________________ "
	elif [ $hpl -eq 10 ]; then 
		l=" IIII____________________ "
	elif [ $hpl -eq 5 ]; then 
		l=" II______________________ "
	elif [ $hpl -eq 0 ]; then 
		l=" ________________________ "
	fi
}


#################### Opponent's param ####################


hpo=30
hpomax=30
stro=5 

opponent_life_bar () {
	if [ $hpo -eq 30 ]; then 
		o=" IIIIIIIIIIIIIIIIIIIIIIII "
	elif [ $hpo -eq 15 ]; then 
		o=" IIIIIIIIIIII____________ "
	elif [ $hpo -eq 0 ]; then 
		o=" ________________________ "
	fi
}


#################### Ganon's param ####################


hpg=350
hpgmax=350
strg=15

ganon_life_bar () {
	i=$hpg
	j=0
	let j=$hpgmax-$hpg
	
	if [ $hpg -gt 0 -a $j -eq 0 ]; then
		high="II"
		k=$hpgmax
		
		while [ $k -gt 5 ]; do
			high="${high}II"
			let k=k-5
		done
		
		g=" $high "
		
	elif [ $hpg -gt 0 -a $j -gt 0 ]; then
		high="II"
		low="__"
	
		while [ $i -gt 5 ]; do
			high="${high}II"
			let i=i-5
		done
		
		while [ $j -gt 5 ]; do
			low="${low}__"
			let j=j-5
		done
		
		g=" ${high}${low} "
	
	else	
		low="__"
		k=$hpgmax
		
		while [ $k -gt 5 ]; do
			low="${low}__"
			let k=k-5
		done
		
		g=" $low "
	fi		
}


#################### Actions choice ####################


choose_action() {
	echo "
--------------Options--------------

1. Attack   2. Heal    0. Run "
}


#################### Link's general actions ####################


link_die() {
	let hpl=$hpl*0
	echo " 
########### Game Over ########## "
	exit;
}


#################### Link's actions against opponent


link_hit() {
	if [ $hpo -gt 0 ]; then
	  let hpo=hpo-$strl
	  opponent_hit
	  opponent_life_bar
	  link_life_bar
	  
	  if [ $hpo -lt 0 ]; then
	  	let hpo=0
	  fi
	  
	  echo -e "
--------------Result--------------
	  
${GREEN}You${NC} attacked and dealt ${GREEN}$strl${NC} damages!
	
${RED}Bokoblin${NC} attacked and dealt ${RED}$stro${NC} damages!

${RED}Bokoblin${NC}
HP : $o ${RED}$hpo/$hpomax${NC}
	
${GREEN}Link${NC}
HP : $l ${GREEN}$hpl/$hplmax "${NC}
	  
	else
	      opponent_die
	fi
}

link_heal() {
	if [ $hpl -lt $hpl_last_potion ]; then
	  let hpl=hpl+$potion
	  opponent_hit
	  opponent_life_bar
	  link_life_bar
	  
          echo -e "
--------------Result--------------

${GREEN}You${NC} used a potion and recovered ${GREEN}$potion${NC} HP!
	
${RED}Bokoblin${NC} attacked and dealt ${RED}$stro${NC} damages!

${RED}Bokoblin${NC}
HP : $o ${RED}$hpo/$hpomax${NC}
	
${GREEN}Link${NC}
HP : $l ${GREEN}$hpl/$hplmax${NC} "
	  
	else
	  let hpl=$hplmax
	  opponent_hit
	  opponent_life_bar
	  link_life_bar
	  
	echo -e "
--------------Result--------------

${GREEN}You${NC} used a potion and recovered ${GREEN}$potion${NC} HP!
	
${RED}Bokoblin${NC} attacked and dealt ${RED}$stro${NC} damages!

${RED}Bokoblin${NC}
HP : $o ${RED}$hpo/$hpomax${NC}
	
${GREEN}Link${NC}
HP : $l ${GREEN}$hpl/$hplmax${NC} "
	     
	fi
}


#################### Link's actions against Ganon 


link_hit_g() {
	if [ $hpg -gt 0 ]; then
	  let hpg=hpg-$strl
	  ganon_hit
	  ganon_life_bar
	  link_life_bar
	  
	  if [ $hpg -lt 0 ]; then
	  	let hpg=0
	  fi
	  
	  echo -e "
--------------Result--------------

${GREEN}You${NC} attacked and dealt ${GREEN}$strl${NC} damages!
	
${PURPLE}Ganon${NC} attacked and dealt ${PURPLE}$strg${NC} damages!	  
	  
${PURPLE}Ganon${NC}
HP : $g ${PURPLE}$hpg/$hpgmax${NC}
	
${GREEN}Link${NC}
HP : $l ${GREEN}$hpl/$hplmax${NC} "
	  
	else
	      ganon_die
	fi
}

link_heal_g() {
	if [ $hpl -lt $hpl_last_potion ]; then
	  let hpl=hpl+$potion
	  ganon_hit
	  ganon_life_bar
	  link_life_bar
	  
          echo -e "
--------------Result--------------

${GREEN}You${NC} used a potion and recovered ${GREEN}$potion${NC} HP!
	
${PURPLE}Ganon${NC} attacked and dealt ${PURPLE}$strg${NC} damages!

${PURPLE}Ganon${NC}
HP : $g ${PURPLE}$hpg/$hpgmax${NC}
	
${GREEN}Link${NC}
HP : $l ${GREEN}$hpl/$hplmax${NC} "
	  
	else
	  let hpl=$hplmax
	  ganon_hit
	  ganon_life_bar
	  link_life_bar
	  
	echo -e "
--------------Result--------------

${GREEN}You${NC} used a potion and recovered ${GREEN}$potion${NC} HP!

${PURPLE}Ganon${NC} attacked and dealt ${PURPLE}$strg${NC} damages!	    
	    
${PURPLE}Ganon${NC}
HP : $g ${PURPLE}$hpg/$hpgmax${NC}
	
${GREEN}Link${NC}
HP : $l ${GREEN}$hpl/$hplmax${NC} "
	     
	fi
}


#################### Opponent's actions ####################


opponent_hit() {
	let hpl=hpl-$stro
	
	 if [ $hpl -lt 0 ]; then
	  	let hpl=0
	 fi
}

opponent_die() {
	echo " 
Bokoblin died! "
}

encounter_opponent() {
	opponent_life_bar
	link_life_bar
	echo -e "
--------------Warning--------------

${GREEN}You${NC} encounter a ${RED}Bokoblin${NC} :

${RED}Bokoblin${NC}
HP : $o ${RED}$hpomax/$hpomax${NC}
	
${GREEN}Link${NC}
HP : $l ${GREEN}$hpl/$hplmax${NC} "
}


#################### Gannon's actions ####################


ganon_hit() {
	let hpl=hpl-$strg
	
	if [ $hpl -lt 0 ]; then
	  	let hpl=0
	fi
}

ganon_die() {
	echo " 
	
Congratulation Ganon has been defeated!
	   
=== Press any key to continue ==="
	exit;
}

encounter_ganon() {
	ganon_life_bar
	link_life_bar
	echo -e "
--------------Warning--------------

${GREEN}You${NC} are facing ${PURPLE}Ganon${NC}! :

${PURPLE}Ganon${NC}
HP : $g ${PURPLE}$hpg/$hpgmax${NC}
	
${GREEN}Link${NC}
HP : $l ${GREEN}$hpl/$hplmax${NC} "
}


#################### Fight ####################


fight() {

######################## STAGES 1-9 ###########################

	count=1
	
	while [ $count -lt 10 ]; do
	
	  encounter_opponent		
	  while [ $hpo -gt 0 ]; do
	  
	    echo "
========= FIGHT " $count"/10 ========="

	    choose_action
	    read act
	  
	  ### heal 
	    if [ $act -eq 2 ]; then
	      link_heal
	    
	  ### attack
	    elif [ $act -eq 1 ]; then
	      link_hit
	    
	  
	  ### quit
	    elif [ $act -eq 0 ]; then
	      echo '
You have been stabbed in the back and died'
	      link_die
	      
	  ### wrong key
	    else
	      echo '
Press 1 to attack, 2 to heal or 0 to quit'
	    
	    fi
	    
	    if [ $hpl -eq 0 -o $hpl -lt 0 -a $hpo -eq 0 -o $hpo -lt 0 ];then
	      opponent_die
	      echo "
Bokoblin defeats you! "
	      link_die
	    fi
	    
	    if [ $hpl -eq 0 -o $hpl -lt 0 ];then
	      echo "
Bokoblin defeats you! "
	      link_die
	    fi
	    
	    if [ $hpo -eq 0 -o $hpo -lt 0 ];then
	      opponent_die
	    fi
	    
	  done
	  
	    let count=$count+1
	    let hpo=$hpomax
	  
	done
	
######################## STAGE 10 ###########################

	encounter_ganon
	
	while [ $hpg -gt 0 ]; do
	  
	    echo "
========= FIGHT " $count"/10 ========="
  
  	    choose_action
	    read act
	  
	  ### heal 
	    if [ $act -eq 2 ]; then
	      link_heal_g
	    
	  ### attack
	    elif [ $act -eq 1 ]; then
	      link_hit_g
	    
	  
	  ### quit
	    elif [ $act -eq 0 ]; then
	      echo '
You ve been stabbed in the back and died'
	      link_die

	  ### wrong key
	    else
	      echo '
Press 1 to attack, 2 to heal or 0 to quit'
	    
	    fi
	    
	    if [ $hpl -eq 0 -a $hpg -eq 0 ]; then
	      echo "
You defeat ganon but die in the battlefield. Welcome to the Valhalla young hero "
	      link_die
	    fi
	    
	    if [ $hpl -eq 0 -o $hpl -lt 0 ]; then
	      echo "
Shame on you, Ganon defeats you! "
	      link_die
	    fi
	    
	    if [ $hpg -eq 0 -o $hpg -lt 0 ]; then
	    	ganon_die
	    fi
	    
	  done
	  			  
}


#################### Main ####################


echo '--------------Options--------------

1. Enter The Hyrule Castle    0. Run'
while [ 1 ]; do
  read key
  if [ $key -eq 1 ]; then
    echo "
Welcome to the Hyrule Castle and get ready to fight! "
    fight
  elif [ $key -eq 0 ]; then
    echo "
You ran away form the battlefield
########### Game Over ##########"
    exit;
  else
    echo "
Please press 0 or 1 to make an action"
  fi
done
