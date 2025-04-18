Config = {}

-- Card background images
Config.Images = {
    mainMenu = "https://upload.wikimedia.org/wikipedia/commons/e/ef/StarfieldSimulation004.gif",
    loginForm = "https://upload.wikimedia.org/wikipedia/commons/e/ef/StarfieldSimulation004.gif",
    welcomeScreen = "https://upload.wikimedia.org/wikipedia/commons/e/ef/StarfieldSimulation004.gif"
}

-- Card styles
Config.Styles = {
    primary = {
        backgroundColor = "#2C3E50",
        textColor = "#FFFFFF"
    },
    secondary = {
        backgroundColor = "#34495E",
        textColor = "#FFFFFF"
    },
    success = {
        backgroundColor = "#27AE60",
        textColor = "#FFFFFF"
    },
    danger = {
        backgroundColor = "#C0392B",
        textColor = "#FFFFFF"
    },
    warning = {
        backgroundColor = "#F39C12",
        textColor = "#FFFFFF"
    },
    info = {
        backgroundColor = "#3498DB",
        textColor = "#FFFFFF"
    }
}

-- Default timeout durations (in milliseconds)
Config.Timeouts = {
    short = 5000,   -- 5 seconds
    medium = 15000, -- 15 seconds
    long = 30000    -- 30 seconds
}
