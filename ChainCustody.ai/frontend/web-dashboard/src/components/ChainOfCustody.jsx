import React, { useEffect, useState } from "react";
import axios from "axios";

const ChainOfCustody = ({ evidenceId }) => {
  const [chain, setChain] = useState([]);

  useEffect(() => {
    const fetchChain = async () => {
      try {
        const response = await axios.get(`/get-chain-of-custody/${evidenceId}`);
        setChain(response.data);
      } catch (error) {
        console.error("Error fetching chain of custody:", error);
      }
    };
    fetchChain();
  }, [evidenceId]);

  return (
    <div>
      <h2>Chain of Custody</h2>
      <ul>
        {chain.map((entry, index) => (
          <li key={index}>
            <strong>{entry.action}</strong>: {entry.timestamp}, {entry.location}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default ChainOfCustody;