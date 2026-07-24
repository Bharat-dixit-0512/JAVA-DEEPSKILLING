import React from 'react';
import './App.css';

function App() {
  const element = "Office Space";
  
  // Using an image attribute with a direct URL as shown in your lab hint
  const jsxatt = <img src="https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=600&q=80" width="25%" height="25%" alt="Office Space" />;

  const officeList = [
    { Name: "DBS", Rent: 50000, Address: "Chennai" }
  ];

  return (
    <div style={{ padding: '20px' }}>
      <h1>{element} , at Affordable Range</h1>

      {jsxatt}

      {officeList.map((ItemName, index) => {
        let colors = [];
        if (ItemName.Rent <= 60000) {
          colors.push('textRed');
        } else {
          colors.push('textGreen');
        }

        return (
          <div key={index}>
            <h1>Name: {ItemName.Name}</h1>
            <h3 className={colors[0]}>
              Rent: Rs. {ItemName.Rent}
            </h3>
            <h3>Address: {ItemName.Address}</h3>
          </div>
        );
      })}
    </div>
  );
}

export default App;