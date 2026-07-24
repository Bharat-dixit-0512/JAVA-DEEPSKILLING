import React from "react";


function EvenPlayers({players}){

    const [,second,,fourth,sixth] = players;


    return(
        <div>

        <h1>Even Players</h1>

        <ul>
            <li>Second : {second}</li>
            <li>Fourth : {fourth}</li>
            <li>Sixth : {sixth}</li>
        </ul>

        </div>
    )
}

export default EvenPlayers;