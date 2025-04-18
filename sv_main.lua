-- sv_main.lua
-- Main server file with Adaptive Cards implementation for deferrals

-- Load functions
local functions = LoadResourceFile(GetCurrentResourceName(), "functions.lua")
load(functions)()

-- Configuration
local Config = {
    Images = {
        mainMenu = "https://upload.wikimedia.org/wikipedia/commons/e/ef/StarfieldSimulation004.gif",
        loginForm = "https://upload.wikimedia.org/wikipedia/commons/e/ef/StarfieldSimulation004.gif",
        welcomeScreen = "https://upload.wikimedia.org/wikipedia/commons/e/ef/StarfieldSimulation004.gif"
    }
}

-- Main connection handler
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local player = source
    deferrals.defer()

    -- Initial loading message
    deferrals.update("Connecting to server...")
    
    -- Wait a moment to simulate loading
    Wait(1000)
    
    -- Start the connection flow
    local status = "main_menu"
    local timeoutDuration = 0
    
    while true do
        local breakLoop = false
        
        if status == "main_menu" then
            -- Example 1: Simple card with a single action
            local mainMenuCard = {
                -- The root element type that defines this as an Adaptive Card
                type = "AdaptiveCard",
                -- The body array contains the card's content elements
                body = {
                    {
                        -- Container: A grouping element that holds other elements
                        type = "Container",
                        -- Sets minimum height of the container in pixels
                        minHeight = "300px",
                        -- Sets minimum width of the container in pixels
                        minWidth = "500px",
                        -- Sets a background image for the container
                        backgroundImage = Config.Images.mainMenu,
                        -- Visual style of the container (default, emphasis, good, attention, warning, accent)
                        style = "default",
                        -- Array of elements contained within this container
                        items = {
                            -- Top-right button (Exit only)
                            {
                                -- ColumnSet: Divides space into columns to arrange elements horizontally
                                type = "ColumnSet",
                                -- Array of column objects that define the layout
                                columns = {
                                    {
                                        -- Column: Container that defines a column within a ColumnSet
                                        type = "Column",
                                        -- Width can be "auto", "stretch", or a weighted value like "1", "2", etc.
                                        width = "stretch"
                                    },
                                    {
                                        type = "Column",
                                        width = "auto",
                                        items = {
                                            {
                                                -- ActionSet: Container for interactive actions like buttons
                                                type = "ActionSet",
                                                -- Array of action objects (buttons)
                                                actions = {
                                                    {
                                                        -- Action.Submit: Creates a button that submits data when clicked
                                                        type = "Action.Submit",
                                                        -- Text displayed on the button
                                                        title = "Exit",
                                                        -- Unique identifier for the button (used in callback)
                                                        id = "submit_quit",
                                                        -- Visual style (default, positive, destructive)
                                                        style = "default",
                                                        -- Text color (dark, light, accent, good, warning, attention)
                                                        color = "light"
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            },
                            -- Centered content (Join and Recovery buttons)
                            {
                                type = "Container",
                                -- Controls vertical alignment of content within container (Top, Center, Bottom)
                                verticalContentAlignment = "Center",
                                -- Controls horizontal alignment of the container itself (Left, Center, Right)
                                horizontalAlignment = "Center",
                                -- Height of container ("auto", "stretch", or specific pixel value)
                                height = "stretch",
                                items = {
                                    {
                                        -- TextBlock: Displays text with various formatting options
                                        type = "TextBlock",
                                        -- Text size (small, default, medium, large, extraLarge)
                                        size = "medium",
                                        -- Font weight (lighter, default, bolder)
                                        weight = "bolder",
                                        -- The actual text content to display
                                        text = "Welcome to the server!",
                                        -- Text color (dark, light, accent, good, warning, attention)
                                        color = "light",
                                        -- Whether text should wrap to multiple lines if needed
                                        wrap = true,
                                        -- Horizontal alignment of text (Left, Center, Right)
                                        horizontalAlignment = "Center"
                                    },
                                    {
                                        type = "TextBlock",
                                        text = "Choose an action:",
                                        color = "light",
                                        wrap = true,
                                        horizontalAlignment = "Center"
                                    },
                                    {
                                        type = "ActionSet",
                                        horizontalAlignment = "Center",
                                        actions = {
                                            {
                                                type = "Action.Submit",
                                                title = "Join",
                                                id = "submit_join",
                                                style = "positive",
                                                color = "light"
                                            },
                                            {
                                                type = "Action.Submit",
                                                title = "Account Recovery",
                                                id = "submit_recovery",
                                                style = "destructive",
                                                color = "light"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                },
                -- Schema URL that defines the Adaptive Card format
                schema = "http://adaptivecards.io/schemas/adaptive-card.json",
                -- Version of the Adaptive Card schema being used
                version = "1.6"
            }
            
            -- Presents the adaptive card to the player during connection
            -- First parameter: the card object to display
            -- Second parameter: callback function that handles user interaction
            deferrals.presentCard(mainMenuCard, function(data, rawData)
                -- data.submitId contains the id of the button that was clicked
                if data.submitId == "submit_join" then
                    status = "join"
                elseif data.submitId == "submit_recovery" then
                    status = "recovery_form"
                elseif data.submitId == "submit_quit" then
                    deferrals.done("You cancelled the connection.")
                    breakLoop = true
                end
            end)
        elseif status == "recovery_form" then
            -- Example 2: Form card with input fields
            local recoveryFormCard = {
                type = "AdaptiveCard",
                body = {
                    {
                        type = "Container",
                        minHeight = "300px",
                        minWidth = "500px",
                        backgroundImage = Config.Images.loginForm,
                        style = "default",
                        items = {
                            -- Top-right buttons (Back and Exit)
                            {
                                type = "ColumnSet",
                                columns = {
                                    {
                                        -- Column: Container that defines a column within a ColumnSet
                                        type = "Column",
                                        -- Width can be "auto", "stretch", or a weighted value like "1", "2", etc.
                                        width = "stretch"
                                    },
                                    {
                                        type = "Column",
                                        width = "auto",
                                        items = {
                                            {
                                                -- ActionSet: Container for interactive actions like buttons
                                                type = "ActionSet",
                                                -- Array of action objects (buttons)
                                                actions = {
                                                    {
                                                        type = "Action.Submit",
                                                        title = "Back",
                                                        id = "submit_back",
                                                        style = "default",
                                                        color = "light"
                                                    },
                                                    {
                                                        -- Action.Submit: Creates a button that submits data when clicked
                                                        type = "Action.Submit",
                                                        -- Text displayed on the button
                                                        title = "Exit",
                                                        -- Unique identifier for the button (used in callback)
                                                        id = "submit_quit",
                                                        -- Visual style (default, positive, destructive)
                                                        style = "default",
                                                        -- Text color (dark, light, accent, good, warning, attention)
                                                        color = "light"
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            },
                            -- Centered content (Recovery form)
                            {
                                type = "Container",
                                -- Controls vertical alignment of content within container (Top, Center, Bottom)
                                verticalContentAlignment = "Center",
                                -- Controls horizontal alignment of the container itself (Left, Center, Right)
                                horizontalAlignment = "Center",
                                -- Height of container ("auto", "stretch", or specific pixel value)
                                height = "stretch",
                                items = {
                                    {
                                        type = "TextBlock",
                                        size = "medium",
                                        weight = "bolder",
                                        text = "Account Recovery",
                                        color = "light",
                                        wrap = true,
                                        horizontalAlignment = "Center"
                                    },
                                    {
                                        type = "TextBlock",
                                        text = "Enter your recovery code:",
                                        color = "light",
                                        wrap = true,
                                        horizontalAlignment = "Center"
                                    },
                                    {
                                        -- Input.Text: Creates a text input field for user data entry
                                        type = "Input.Text",
                                        -- Unique identifier for accessing the input value
                                        id = "recovery_code",
                                        -- Hint text displayed when the field is empty
                                        placeholder = "Recovery Code",
                                        -- Input style (text, tel, url, email, password)
                                        style = "text"
                                    },
                                    {
                                        type = "ActionSet",
                                        horizontalAlignment = "Center",
                                        actions = {
                                            {
                                                type = "Action.Submit",
                                                title = "Submit",
                                                id = "submit_code",
                                                style = "positive",
                                                color = "light"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                },
                -- Schema URL that defines the Adaptive Card format
                schema = "http://adaptivecards.io/schemas/adaptive-card.json",
                -- Version of the Adaptive Card schema being used
                version = "1.6"
            }
            
            deferrals.presentCard(recoveryFormCard, function(data, rawData)
                if data.submitId == "submit_code" then
                    -- Example of checking a recovery code
                    -- Access input field values using data.[field_id]
                    local recoveryCode = data.recovery_code
                    
                    if recoveryCode == "12345" then -- Example code
                        status = "code_accepted"
                    else
                        status = "code_rejected"
                        timeoutDuration = 5000 -- 5 seconds timeout
                    end
                elseif data.submitId == "submit_back" then
                    status = "main_menu"
                elseif data.submitId == "submit_quit" then
                    deferrals.done("You cancelled the connection.")
                    breakLoop = true
                end
            end)
        elseif status == "code_accepted" then
            -- Example 3: Success message with standard deferrals
            local message = "✅ Code Accepted ✅\n\n"
            message = message .. "🎉 You have successfully recovered your account!\n\n"
            message = message .. "🕒 Redirecting to server..."
            
            deferrals.update(message)
            
            -- Wait for a few seconds to show the message
            Wait(3000)
            
            -- Allow the player to connect
            deferrals.done()
            breakLoop = true
        elseif status == "code_rejected" then
            -- Example 4: Timeout with countdown
            local startTime = GetGameTimer()
            local endTime = startTime + timeoutDuration
            
            -- Function to update the deferral message with the remaining time
            local function updateTimer()
                local remainingTime = math.max(0, endTime - GetGameTimer())
                local seconds = math.ceil(remainingTime / 1000)
                
                if remainingTime > 0 then
                    -- Multi-line deferral message
                    local message = "⏳ Timeout before next attempt ⏳\n\n"
                    message = message .. "⚠️ Warning: Reconnecting will restart the timer!\n\n"
                    message = message .. "🕒 Time remaining: " .. seconds .. " sec."
                    
                    -- Update the deferral message
                    deferrals.update(message)
                    Wait(1000) -- Wait 1 second
                    updateTimer() -- Update the timer again
                else
                    -- Timer expired, redirect to recovery form
                    status = "recovery_form"
                end
            end
            
            -- Start the timer
            updateTimer()
        elseif status == "join" then
            -- Example 5: Complex card with multiple visual elements
            local welcomeCard = {
                type = "AdaptiveCard",
                body = {
                    {
                        type = "Container",
                        minHeight = "300px",
                        minWidth = "500px",
                        backgroundImage = Config.Images.welcomeScreen,
                        style = "default",
                        items = {
                            -- Header with server name
                            {
                                type = "TextBlock",
                                size = "large",
                                weight = "bolder",
                                text = "PyroByte Server",
                                color = "light",
                                wrap = true,
                                horizontalAlignment = "Center"
                            },
                            -- Server information
                            {
                                type = "ColumnSet",
                                columns = {
                                    {
                                        type = "Column",
                                        width = "1",
                                        items = {
                                            {
                                                type = "TextBlock",
                                                text = "Players Online:",
                                                color = "light",
                                                horizontalAlignment = "right"
                                            },
                                            {
                                                type = "TextBlock",
                                                text = "Server Status:",
                                                color = "light",
                                                horizontalAlignment = "right"
                                            },
                                            {
                                                type = "TextBlock",
                                                text = "Your Name:",
                                                color = "light",
                                                horizontalAlignment = "right"
                                            }
                                        }
                                    },
                                    {
                                        type = "Column",
                                        width = "1",
                                        items = {
                                            {
                                                type = "TextBlock",
                                                text = "32/64",
                                                color = "light",
                                                weight = "bolder"
                                            },
                                            {
                                                type = "TextBlock",
                                                text = "Online",
                                                color = "light",
                                                weight = "bolder"
                                            },
                                            {
                                                type = "TextBlock",
                                                text = name,
                                                color = "light",
                                                weight = "bolder"
                                            }
                                        }
                                    }
                                }
                            },
                            -- Server rules acceptance
                            {
                                type = "Container",
                                spacing = "medium",
                                items = {
                                    {
                                        type = "TextBlock",
                                        text = "Server Rules:",
                                        color = "light",
                                        weight = "bolder",
                                        horizontalAlignment = "center"
                                    },
                                    {
                                        type = "TextBlock",
                                        text = "1. Be respectful to other players\n2. No cheating or exploiting\n3. Follow staff instructions",
                                        color = "light",
                                        wrap = true,
                                        horizontalAlignment = "center"
                                    },
                                    {
                                        -- Input.Toggle: Creates a checkbox/toggle control
                                        type = "Input.Toggle",
                                        -- Unique identifier for accessing the toggle state
                                        id = "rules_accepted",
                                        -- Label text displayed next to the toggle
                                        title = "I accept the server rules",
                                        -- Default value ("true" or "false")
                                        value = "false"
                                    }
                                }
                            },
                            -- Action buttons
                            {
                                type = "ActionSet",
                                horizontalAlignment = "center",
                                actions = {
                                    {
                                        type = "Action.Submit",
                                        title = "Join Server",
                                        id = "submit_join_final",
                                        style = "positive",
                                        color = "light"
                                    },
                                    {
                                        type = "Action.Submit",
                                        title = "Back",
                                        id = "submit_back",
                                        style = "default",
                                        color = "light"
                                    }
                                }
                            }
                        }
                    }
                },
                -- Schema URL that defines the Adaptive Card format
                schema = "http://adaptivecards.io/schemas/adaptive-card.json",
                -- Version of the Adaptive Card schema being used
                version = "1.6"
            }
            
            deferrals.presentCard(welcomeCard, function(data, rawData)
                if data.submitId == "submit_join_final" then
                    if data.rules_accepted == "true" then
                        -- Allow the player to connect
                        deferrals.done()
                    else
                        -- Require rules acceptance
                        deferrals.update("You must accept the server rules to join.")
                        Wait(2000)
                        status = "join" -- Show the card again
                    end
                    breakLoop = (data.rules_accepted == "true")
                elseif data.submitId == "submit_back" then
                    status = "main_menu"
                end
            end)
        end
        
        if breakLoop then
            break
        end
        
        Wait(100)
    end
end)
