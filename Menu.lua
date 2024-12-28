-- Получаем ссылку на игрока
local player = game.Players.LocalPlayer

-- Создание основного GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Флаг для отслеживания состояния руки
local isRightArmRaised = false

-- Функция для создания и отображения главной кнопки
local function createMainButton()
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 50) -- Размер кнопки
    button.Position = UDim2.new(0.5, -100, 0.5, -25) -- Позиция кнопки по центру экрана
    button.Text = "Открыть меню" -- Текст на кнопке
    button.TextColor3 = Color3.fromRGB(255, 255, 255) -- Цвет текста
    button.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Цвет фона кнопки
    button.Parent = screenGui

    -- Создание меню, которое скрыто по умолчанию
    local menuFrame = Instance.new("Frame")
    menuFrame.Size = UDim2.new(0, 200, 0, 100) -- Размер меню
    menuFrame.Position = UDim2.new(0.5, -100, 0.5, -50) -- Позиция меню по центру
    menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Цвет фона меню
    menuFrame.BackgroundTransparency = 0.5
    menuFrame.Visible = false -- Меню скрыто по умолчанию
    menuFrame.Parent = screenGui

    -- Создание кнопки "Ziga" в меню
    local zigaButton = Instance.new("TextButton")
    zigaButton.Size = UDim2.new(0, 180, 0, 50) -- Размер кнопки
    zigaButton.Position = UDim2.new(0, 10, 0, 25) -- Позиция кнопки
    zigaButton.Text = "Ziga" -- Текст на кнопке
    zigaButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- Цвет текста
    zigaButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Цвет фона кнопки
    zigaButton.Parent = menuFrame

    -- Функция для открытия/закрытия меню
    local function toggleMenu()
        menuFrame.Visible = not menuFrame.Visible
    end

    -- Привязываем действие открытия меню к кнопке
    button.MouseButton1Click:Connect(toggleMenu)

    -- Функция для выполнения действия при нажатии на кнопку Ziga
    local function onZigaButtonClick()
        print("Кнопка Ziga нажата!")
        -- Включаем или выключаем поднимание руки в зависимости от состояния
        if isRightArmRaised then
            lowerRightArm()  -- Опускаем руку
        else
            raiseRightArm()  -- Поднимаем руку
        end
        -- Переключаем состояние
        isRightArmRaised = not isRightArmRaised
    end

    -- Привязываем событие нажатия на кнопку "Ziga"
    zigaButton.MouseButton1Click:Connect(onZigaButtonClick)
end

-- Получаем ссылку на персонажа
local character = player.Character or player.CharacterAdded:Wait()
local rightShoulder = character:WaitForChild("RightUpperArm"):WaitForChild("RightShoulder")

-- Функция для изменения угла плеча (поднять руку на 110°)
local function raiseRightArm()
    -- Получаем текущий угол
    local currentAngle = rightShoulder.C0
    -- Применяем изменение на 110 градусов (переводим в радианы)
    local newAngle = currentAngle * CFrame.Angles(math.rad(-110), 0, 0) -- Поднимаем руку вверх на 110 градусов
    -- Устанавливаем новый угол
    rightShoulder.C0 = newAngle
end

-- Функция для изменения угла плеча (опустить руку)
local function lowerRightArm()
    -- Получаем текущий угол
    local currentAngle = rightShoulder.C0
    -- Применяем изменение на 110 градусов (переводим в радианы)
    local newAngle = currentAngle * CFrame.Angles(math.rad(110), 0, 0) -- Опускаем руку вниз
    -- Устанавливаем новый угол
    rightShoulder.C0 = newAngle
end

-- Обработчик команд чата
game.Players.LocalPlayer.Chatted:Connect(function(message)
    if message:lower() == ";menu" then
        createMainButton()  -- Создаём главную кнопку при вводе команды ";Menu"
    end
end)
