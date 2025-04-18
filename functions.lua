-- functions.lua
-- Contains helper functions for Adaptive Cards

-- Simple card example
-- Parameters:
--   title: The main heading text for the card
--   message: The descriptive text content
--   buttonText: Text displayed on the action button
--   buttonId: Unique identifier for the button (used in callback)
function CreateSimpleCard(title, message, buttonText, buttonId)
    local adaptiveCard = {
        type = "AdaptiveCard",
        body = {
            {
                type = "Container",
                minHeight = "300px",
                minWidth = "500px",
                style = "default",
                items = {
                    {
                        type = "TextBlock",
                        size = "medium",
                        weight = "bolder",
                        text = title,
                        color = "light",
                        wrap = true,
                        horizontalAlignment = "Center"
                    },
                    {
                        type = "TextBlock",
                        text = message,
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
                                title = buttonText,
                                id = buttonId,
                                style = "positive",
                                color = "light"
                            }
                        }
                    }
                }
            }
        },
        schema = "http://adaptivecards.io/schemas/adaptive-card.json",
        version = "1.6"
    }
    
    return adaptiveCard
end

-- Multi-action card example
-- Parameters:
--   title: The main heading text for the card
--   message: The descriptive text content
--   actions: Array of action objects with properties:
--     - title: Text displayed on the button
--     - id: Unique identifier for the button
--     - style: Visual style (default, positive, destructive)
--     - color: Text color (dark, light, accent, good, warning, attention)
function CreateMultiActionCard(title, message, actions)
    local actionsList = {}
    
    for _, action in ipairs(actions) do
        table.insert(actionsList, {
            type = "Action.Submit",
            title = action.title,
            id = action.id,
            style = action.style or "default",
            color = action.color or "light"
        })
    end
    
    local adaptiveCard = {
        type = "AdaptiveCard",
        body = {
            {
                type = "Container",
                minHeight = "300px",
                minWidth = "500px",
                style = "default",
                items = {
                    {
                        type = "TextBlock",
                        size = "medium",
                        weight = "bolder",
                        text = title,
                        color = "light",
                        wrap = true,
                        horizontalAlignment = "Center"
                    },
                    {
                        type = "TextBlock",
                        text = message,
                        color = "light",
                        wrap = true,
                        horizontalAlignment = "Center"
                    },
                    {
                        type = "ActionSet",
                        horizontalAlignment = "Center",
                        actions = actionsList
                    }
                }
            }
        },
        schema = "http://adaptivecards.io/schemas/adaptive-card.json",
        version = "1.6"
    }
    
    return adaptiveCard
end

-- Form card example
-- Parameters:
--   title: The main heading text for the card
--   message: The descriptive text content
--   inputFields: Array of input field objects with properties:
--     - id: Unique identifier for accessing the input value
--     - placeholder: Hint text displayed when field is empty
--     - style: Input style (text, tel, url, email, password)
--   submitButtonText: Text displayed on the submit button
--   submitButtonId: Unique identifier for the submit button
--   backButtonText: Text displayed on the back button (optional)
--   backButtonId: Unique identifier for the back button (optional)
function CreateFormCard(title, message, inputFields, submitButtonText, submitButtonId, backButtonText, backButtonId)
    local inputItems = {}
    
    for _, field in ipairs(inputFields) do
        table.insert(inputItems, {
            type = "Input.Text",
            id = field.id,
            placeholder = field.placeholder,
            style = field.style or "text"
        })
    end
    
    local actions = {}
    
    if backButtonText and backButtonId then
        table.insert(actions, {
            type = "Action.Submit",
            title = backButtonText,
            id = backButtonId,
            style = "default",
            color = "light"
        })
    end
    
    table.insert(actions, {
        type = "Action.Submit",
        title = submitButtonText,
        id = submitButtonId,
        style = "positive",
        color = "light"
    })
    
    local adaptiveCard = {
        type = "AdaptiveCard",
        body = {
            {
                type = "Container",
                minHeight = "300px",
                minWidth = "500px",
                style = "default",
                items = {
                    {
                        type = "TextBlock",
                        size = "medium",
                        weight = "bolder",
                        text = title,
                        color = "light",
                        wrap = true,
                        horizontalAlignment = "Center"
                    },
                    {
                        type = "TextBlock",
                        text = message,
                        color = "light",
                        wrap = true,
                        horizontalAlignment = "Center"
                    }
                }
            }
        },
        schema = "http://adaptivecards.io/schemas/adaptive-card.json",
        version = "1.6"
    }
    
    -- Add input fields
    for _, inputItem in ipairs(inputItems) do
        table.insert(adaptiveCard.body[1].items, inputItem)
    end
    
    -- Add action set with buttons
    table.insert(adaptiveCard.body[1].items, {
        type = "ActionSet",
        horizontalAlignment = "Center",
        actions = actions
    })
    
    return adaptiveCard
end

-- Complex card with custom layout
-- Parameters:
--   title: The main heading text for the card
--   message: The descriptive text content
--   backgroundImage: URL to the image used as background
function CreateComplexCard(title, message, backgroundImage)
    local adaptiveCard = {
        type = "AdaptiveCard",
        body = {
            {
                type = "Container",
                minHeight = "300px",
                minWidth = "500px",
                backgroundImage = backgroundImage,
                style = "default",
                items = {
                    -- Top-right buttons (Back and Exit)
                    {
                        type = "ColumnSet",
                        columns = {
                            {
                                type = "Column",
                                width = "stretch"
                            },
                            {
                                type = "Column",
                                width = "auto",
                                items = {
                                    {
                                        type = "ActionSet",
                                        actions = {
                                            {
                                                type = "Action.Submit",
                                                title = "Back",
                                                id = "submit_back",
                                                style = "default",
                                                color = "light"
                                            },
                                            {
                                                type = "Action.Submit",
                                                title = "Exit",
                                                id = "submit_quit",
                                                style = "default",
                                                color = "light"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    },
                    -- Centered content
                    {
                        type = "Container",
                        verticalContentAlignment = "Center",
                        horizontalAlignment = "Center",
                        height = "stretch",
                        items = {
                            {
                                type = "TextBlock",
                                size = "medium",
                                weight = "bolder",
                                text = title,
                                color = "light",
                                wrap = true,
                                horizontalAlignment = "Center"
                            },
                            {
                                type = "TextBlock",
                                text = message,
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
                                        title = "Option 1",
                                        id = "submit_option1",
                                        style = "positive",
                                        color = "light"
                                    },
                                    {
                                        type = "Action.Submit",
                                        title = "Option 2",
                                        id = "submit_option2",
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
        schema = "http://adaptivecards.io/schemas/adaptive-card.json",
        version = "1.6"
    }
    
    return adaptiveCard
end
