import React from "react";

function ListofPlayers({players}){

    return(
        <div>
            <h1>List of Players</h1>

            <ul>
                {
                    players.map((item,index)=>(
                        <li key={index}>
                            Mr. {item.name} {item.score}
                        </li>
                    ))
                }
            </ul>
        </div>
    )
}

export default ListofPlayers;