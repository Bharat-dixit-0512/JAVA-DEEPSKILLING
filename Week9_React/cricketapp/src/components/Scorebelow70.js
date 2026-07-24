import React from "react";

function Scorebelow70({players}){

    const players70 = players.filter(
        (item)=> item.score < 70
    );

    return(
        <div>
            <h1>
                List of Players having Scores Less than 70
            </h1>

            <ul>
            {
                players70.map((item,index)=>(
                    <li key={index}>
                        Mr. {item.name} {item.score}
                    </li>
                ))
            }
            </ul>

        </div>
    )
}

export default Scorebelow70;