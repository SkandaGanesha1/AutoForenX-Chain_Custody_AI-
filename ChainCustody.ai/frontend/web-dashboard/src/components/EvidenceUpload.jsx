import React, { useState } from "react";
import axios from "axios";

const EvidenceUpload = () => {
  const [file, setFile] = useState(null);
  const [location, setLocation] = useState("");
  const [message, setMessage] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    const formData = new FormData();
    formData.append("file", file);
    formData.append("location", location);

    try {
      const response = await axios.post("/collect-evidence", formData, {
        headers: { "Content-Type": "multipart/form-data" },
      });
      setMessage(`Evidence uploaded successfully! ID: ${response.data.evidence_id}`);
    } catch (error) {
      setMessage("Error uploading evidence.");
    }
  };

  return (
    <div>
      <h2>Upload Evidence</h2>
      <form onSubmit={handleSubmit}>
        <input type="file" onChange={(e) => setFile(e.target.files[0])} required />
        <input
          type="text"
          placeholder="Location"
          value={location}
          onChange={(e) => setLocation(e.target.value)}
          required
        />
        <button type="submit">Upload</button>
      </form>
      {message && <p>{message}</p>}
    </div>
  );
};

export default EvidenceUpload;