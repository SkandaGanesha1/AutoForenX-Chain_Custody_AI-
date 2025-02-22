import React, { useEffect, useState } from "react";
import axios from "axios";

const AIInsights = ({ evidenceId }) => {
  const [insights, setInsights] = useState({});

  useEffect(() => {
    const fetchInsights = async () => {
      try {
        const response = await axios.get(`/verify-evidence/${evidenceId}`);
        setInsights(response.data);
      } catch (error) {
        console.error("Error fetching AI insights:", error);
      }
    };
    fetchInsights();
  }, [evidenceId]);

  return (
    <div>
      <h2>AI Insights</h2>
      <p>Tampering Detected: {insights.is_valid ? "No" : "Yes"}</p>
    </div>
  );
};

export default AIInsights;