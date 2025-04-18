Config = {}

-- Card background images
Config.Images = {
    default = "https://via.placeholder.com/500x300",
    login = "https://via.placeholder.com/500x300",
    profile = "https://via.placeholder.com/500x300",
    menu = "https://via.placeholder.com/500x300"
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
