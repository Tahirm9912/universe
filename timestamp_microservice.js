
import express from "express";
import cors from "cors";

const app = express();

app.use(cors({ optionsSuccessStatus: 200 }));

app.use(express.static("public"));

app.get("/", (_req, res) => {
  res.sendFile(import.meta.dirname + "/views/index.html");
});

// Do not change code above this line

// Route for a specific date or Unix timestamp
app.get("/api/:date", (req, res) => {
  const dateParam = req.params.date;

  let date;

  // Check if the input is a Unix timestamp
  if (/^-?\d+$/.test(dateParam)) {
    date = new Date(Number(dateParam));
  } else {
    // Parse a regular date string
    date = new Date(dateParam);
  }

  // Handle invalid dates
  if (isNaN(date.getTime())) {
    return res.json({ error: "Invalid Date" });
  }

  // Return Unix timestamp and UTC date
  res.json({
    unix: date.getTime(),
    utc: date.toUTCString()
  });
});

// Route for an empty date parameter (current time)
app.get("/api", (_req, res) => {
  const date = new Date();

  res.json({
    unix: date.getTime(),
    utc: date.toUTCString()
  });
});

// Do not change code below this line

const PORT = 8000;

const listener = app.listen(PORT, function () {
  console.log("Your app is listening on port " + PORT);
});
