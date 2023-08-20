function SetLeaderboardDisplay(bool, myKillcount, myDeathcount, topUsers) {
    var element = document.getElementById("leaderboard-ui");
    element.style.display = bool ? "block" : "none";
    var kdr = (myKillcount / myDeathcount).toFixed(2);
    document.getElementById("js--PersonalKills").innerHTML = "Kills: "+ myKillcount;
    document.getElementById("js--PersonalDeaths").innerHTML = "Death: "+ myDeathcount;
    document.getElementById("js--PersonalKD").innerHTML = "K/D: "+ kdr;
    document.getElementById("js--MyRank").src= "img/"+GetRankByKD(kdr, "myrank");
    document.getElementById("js--NextRank").src= "img/"+GetRankByKD(kdr, "nextrank");


topUsers.forEach(userData => {
    const liId = `rank${userData.Rank}`;
    const liElement = document.getElementById(liId);

    if (liElement) {
        liElement.querySelector(".Rank").textContent = userData.Rank;
        liElement.querySelector(".Player").textContent = userData.User;
        liElement.querySelector(".Kills").textContent = userData.Kills;
        liElement.querySelector(".Deaths").textContent = userData.Deaths;
        liElement.querySelector(".KD").textContent = userData.KDRatio;


        const rankLogo = GetRankByKD(userData.KDRatio, "myrank");
        liElement.querySelector(".RankLogo img").src = `img/${rankLogo}`;
    } else {
        console.error(`Element with ID ${liId} not found.`);
    }
});
    
    if (bool == false) {
        fetch(`https://${GetParentResourceName()}/CloseLeaderboardScreen`, {
            method: 'POST',
            mode: 'no-cors',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify(["a"])
        }).then(resp => resp.json()).then(resp => console.log(resp));
    }
}


function GetRankByKD(kd, type){
    rank = "silver1.png";
    if(kd < 0.20){
        rank = "silver1.png";
        nextrank = "silver2.png";
    }
    else if(kd < 0.40){
        rank = "silver2.png";
        nextrank = "silver3.png";
    }
    else if(kd < 0.60){
        rank = "silver3.png";
        nextrank = "silver4.png";
    }
    else if(kd < 0.80){
        rank = "silver4.png";
        nextrank = "silver5.png";
    }
    else if(kd < 1.00){
        rank = "silver5.png";
        nextrank = "gold1.png";
    }
    else if(kd < 1.20){
        rank = "gold1.png";
        nextrank = "gold2.png";
    }
    else if(kd < 1.40){
        rank = "gold2.png";
        nextrank = "gold3.png";
    }
    else if(kd < 1.60){
        rank = "gold3.png";
        nextrank = "gold4.png";
    }
    else if(kd < 1.80){
        rank = "gold4.png";
        nextrank = "mg1.png";
    }
    else if(kd < 2.00){
        rank = "mg1.png";
        nextrank = "mg2.png";
    }
    else if(kd < 2.20){
        rank = "mg2.png";
        nextrank = "mg3.png";
    }
    else if(kd < 2.40){
        rank = "mg3.png";
        nextrank = "dmg.png";
    }
    else if(kd < 2.60){
        rank = "dmg.png";
        nextrank = "le.png";
    }
    else if(kd < 3.00){
        rank = "le.png";
        nextrank = "le2.png";
    }
    else if(kd < 3.40){
        rank = "le2.png";
        nextrank = "supreme.png";
    }
    else if(kd < 3.80){
        rank = "supreme.png";
        nextrank = "global.png";
    }
    else if(kd < 4.19){
        rank = "global.png";
        nextrank = ".png";
    }
    else if(kd > 4.19){
        rank = "global.png";
        nextrank = ".png";
    }
    if(type == "myrank"){
        return(rank);
    }else{
        return(nextrank);
    }
}
function CloseLeaderboardDisplay(){
    bool = false
     var element = document.getElementById("leaderboard-ui");
    element.style.display = bool ? "block" : "none";
    if (bool == false) {
        fetch(`https://${GetParentResourceName()}/CloseLeaderboardScreen`, {
            method: 'POST',
            mode: 'no-cors',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify(["a"])
        }).then(resp => resp.json()).then(resp => console.log(resp));
    }
}

document.addEventListener("DOMContentLoaded", function(){
    window.addEventListener('message', function(event) {
        if (event.data != null) {
            var data = event.data.data;
            var toggleUI = event.data.toggleUI;
            var myKillcount = event.data.killCount1;
            var myDeathcount = event.data.deathCount1;
            var topUsers = event.data.TopUsers1;
            if (toggleUI != null) {
                SetLeaderboardDisplay(toggleUI, myKillcount, myDeathcount, topUsers);
            }
        }
    });
});