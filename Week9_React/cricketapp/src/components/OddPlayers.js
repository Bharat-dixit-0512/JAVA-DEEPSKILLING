import React from "react";


function OddPlayers({players}){

    const [first, , third, , fifth] = players;


    return(
        <div>

        <h1>Odd Players</h1>

        <ul>
            <li>First : {first}</li>
            <li>Third : {third}</li>
            <li>Fifth : {fifth}</li>
        </ul>

        </div>
    )
}

export default OddPlayers;