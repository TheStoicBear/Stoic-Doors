
Config = {}
-- ForceTarget: 
-- - Set to true to enable the feature that forces players to use the target to enter vehicles.
-- - Set to false to disable this feature.
Config.ForceTarget = false

-- ToolTips:
-- - Set to true to enable tooltips.
-- - Set to false to disable tooltips.
Config.ToolTips = false

-- ToolTipsHelpText: 
-- - Specify the help text for the tooltip.
Config.ToolTipsHelpText = "Please use your 3rd eye to enter the vehicle"

-- ToolTipTime:
-- - Specify the duration (in milliseconds) for which the tooltip is displayed.
Config.ToolTipTime = 4000

-- ToolTipPosition:
-- - Specify the position of the tooltip. Options: "top-left", "top-center", "top-right", "bottom-left", "bottom-center", "bottom-right".
Config.ToolTipPosition = "bottom-center"

-- ToolTipBackground:
-- - Specify the background color of the tooltip.
Config.ToolTipBackground = 'dark-grey'

-- ToolTipTextColor:
-- - Specify the text color of the tooltip.
Config.ToolTipTextColor = '#919191'

-- ToolTipBorderRadius:
-- - Specify the border radius of the tooltip.
Config.ToolTipBorderRadius = 5

-- ToolTipIcon:
-- - Specify the icon to be displayed in the tooltip. This can be any FontAwesome icon.
Config.ToolTipIcon = 'eye'

-- ToolTipIconColor:
-- - Specify the icon color to be displayed in the tooltip.
Config.ToolTipIconColor = '#fc8f28'

-- Configuration for Front Driver Door entry

-- driverFName:
-- - Specify the name of the entry for getting in the front driver door.
Config.driverFName = 'ox_target:driverF'

-- driverFIcon:
-- - Specify the icon for the front driver door entry.
Config.driverFIcon = 'fa-solid fa-car-side'

-- driverFLabel:
-- - Specify the label for the front driver door entry.
Config.driverFLabel = 'Get in Front Driver Door'

-- driverFDistance:
-- - Specify the distance at which the front driver door entry becomes available.
Config.driverFDistance = 2


-- Configuration for Front Passenger Door entry

-- passengerFName:
-- - Specify the name of the entry for getting in the front passenger door.
Config.passengerFName = 'ox_target:passengerF'

-- passengerFIcon:
-- - Specify the icon for the front passenger door entry.
Config.passengerFIcon = 'fa-solid fa-car-side'

-- passengerFLabel:
-- - Specify the label for the front passenger door entry.
Config.passengerFLabel = 'Get in Front Passenger Door'

-- passengerFDistance:
-- - Specify the distance at which the front passenger door entry becomes available.
Config.passengerFDistance = 2


-- Configuration for Rear Driver Door entry

-- driverRName:
-- - Specify the name of the entry for getting in the rear driver door.
Config.driverRName = 'ox_target:driverR'

-- driverRIcon:
-- - Specify the icon for the rear driver door entry.
Config.driverRIcon = 'fa-solid fa-car-side'

-- driverRLabel:
-- - Specify the label for the rear driver door entry.
Config.driverRLabel = 'Get in Rear Driver Door'

-- driverRDistance:
-- - Specify the distance at which the rear driver door entry becomes available.
Config.driverRDistance = 2


-- Configuration for Rear Passenger Door entry

-- passengerRName:
-- - Specify the name of the entry for getting in the rear passenger door.
Config.passengerRName = 'ox_target:passengerR'

-- passengerRIcon:
-- - Specify the icon for the rear passenger door entry.
Config.passengerRIcon = 'fa-solid fa-car-side'

-- passengerRLabel:
-- - Specify the label for the rear passenger door entry.
Config.passengerRLabel = 'Get in Rear Passenger Door'

-- passengerRDistance:
-- - Specify the distance at which the rear passenger door entry becomes available.
Config.passengerRDistance = 2


-- Other configurations can be added here if needed

-- Bone configuration
-- - Specifies the bone names for different vehicle doors.
-- - Modify these values if necessary.
Config.bones = 
{
    [0] = 'dside_f',
    [1] = 'pside_f',
    [2] = 'dside_r',
    [3] = 'pside_r'
}
