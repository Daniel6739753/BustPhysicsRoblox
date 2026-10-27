--Bust Physics v2.5.5
--Written: Daniel6739753

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local version = "v2.5.5"

-- ==========================================
-- 0. INITIALIZATION (EXPLOIT MODE)
-- ==========================================
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local PlayerGui = game:GetService("CoreGui") -- UI in CoreGui to bypass anti-cheats

-- Global flag to stop all processes when destroyed
local scriptActive = true

-- ==========================================
-- 1. SETTINGS (BUST + BUTT + BODY)
-- ==========================================
local PANTIES_SHIRT_ID = "115458648737508" -- Panties shirt (white overlay)
local BODY_MAX_WHITE = Color3.fromRGB(249, 249, 249) -- Max white body color to remove contrast with 255 texture

-- BLACKLIST NOTE: Skip this shirt for BUST texture only (uses pants instead), but keep it visible on the BODY and BUTT
local BLACKLISTED_SHIRTS = { PANTIES_SHIRT_ID }

local DEFAULT_SETTINGS = {
	-- Body
	FORCE_BODY_FIRST_PERSON = false, -- Special fix for custom camera games like Grace
	-- Bust
	FORCE_FIRST_PERSON_VISIBILITY = false,
	HIDE_ALL_BUSTS = false,
	LOCAL_PLAYER_ONLY = false,
	STIFFNESS = 150,
	DAMPING = 5,
	INERTIA_SCALE_ROT = 2,
	INERTIA_SCALE_LIN = 0.07,
	MAX_DEVIATION = math.rad(15),
	SOFTNESS = 0.15,
	CLOTH_WEIGHT = -15,
	MODEL_SCALE = 1.1,
	MOTOR_OFFSET_X = 0.25,
	MOTOR_OFFSET_Y = -0.10,
	MOTOR_OFFSET_Z = 0.0,
	-- Butt
	BUTT_PHYSICS_ENABLED = true,
	BUTT_STIFFNESS = 200,
	BUTT_DAMPING = 8,
	BUTT_INERTIA_ROT = 2.5,
	BUTT_INERTIA_LIN = 0.12,
	BUTT_INERTIA_Y_Z = 0.06,
	BUTT_MAX_DEV = math.rad(15),
	BUTT_SOFTNESS = 0.20
}

local HUGE_PRESET = {
	FORCE_BODY_FIRST_PERSON = false, FORCE_FIRST_PERSON_VISIBILITY = false, HIDE_ALL_BUSTS = false, LOCAL_PLAYER_ONLY = false,
	STIFFNESS = 105, DAMPING = 6, INERTIA_SCALE_ROT = 2.75, INERTIA_SCALE_LIN = 0.09,
	MAX_DEVIATION = math.rad(15), SOFTNESS = 0.10, CLOTH_WEIGHT = -20, MODEL_SCALE = 1.50,
	MOTOR_OFFSET_X = 0.58, MOTOR_OFFSET_Y = 0.13, MOTOR_OFFSET_Z = 0.0,
	BUTT_STIFFNESS = 160, BUTT_DAMPING = 5, BUTT_INERTIA_ROT = 2.2, BUTT_INERTIA_LIN = 0.12, BUTT_INERTIA_Y_Z = 0.07
}

local INFLATED_PRESET = {
	FORCE_BODY_FIRST_PERSON = false, FORCE_FIRST_PERSON_VISIBILITY = false, HIDE_ALL_BUSTS = false, LOCAL_PLAYER_ONLY = false,
	STIFFNESS = 250, DAMPING = 6, INERTIA_SCALE_ROT = 5.0, INERTIA_SCALE_LIN = 0.07,
	MAX_DEVIATION = math.rad(15), SOFTNESS = 0.05, CLOTH_WEIGHT = 20.0, MODEL_SCALE = 1.50,
	MOTOR_OFFSET_X = 0.55, MOTOR_OFFSET_Y = 0.15, MOTOR_OFFSET_Z = 0.0,
	BUTT_STIFFNESS = 325, BUTT_DAMPING = 7, BUTT_INERTIA_ROT = 3.0, BUTT_INERTIA_LIN = 0.10, BUTT_INERTIA_Y_Z = 0.06
}

local INTENSIVE_PRESET = {
	FORCE_BODY_FIRST_PERSON = false, FORCE_FIRST_PERSON_VISIBILITY = false, HIDE_ALL_BUSTS = false, LOCAL_PLAYER_ONLY = false,
	STIFFNESS = 150, DAMPING = 5, INERTIA_SCALE_ROT = 2.85, INERTIA_SCALE_LIN = 0.14,
	MAX_DEVIATION = math.rad(12), SOFTNESS = 0.20, CLOTH_WEIGHT = -10.0, MODEL_SCALE = 1.10,
	MOTOR_OFFSET_X = 0.25, MOTOR_OFFSET_Y = -0.10, MOTOR_OFFSET_Z = 0.0,
	BUTT_STIFFNESS = 175, BUTT_DAMPING = 7, BUTT_INERTIA_ROT = 3.6, BUTT_INERTIA_LIN = 0.18, BUTT_INERTIA_Y_Z = 0.10,
	BUTT_SOFTNESS = 0.15, BUTT_MAX_DEV = math.rad(10)
}

local Settings = {}
for k, v in pairs(DEFAULT_SETTINGS) do Settings[k] = v end

local BUST_BASE_C0 = CFrame.new(0, 0.1, -0.25) * CFrame.Angles(0, math.rad(-90), 0)
local BUTT_BASE_C0 = CFrame.new(0, -1.1, 0.15) * CFrame.Angles(0, math.rad(90), math.rad(-5))
local BUTT_BASE_C1 = CFrame.new(0.4, 0, 0)

local TARGET_MESH_ID = "48112070" -- Unified body check

-- ==========================================
-- 2. JSON STRINGS (BODY + BUST)
-- ==========================================
local bodyJsonString = [[{"Children":[{"Children":[{"Children":[],"Properties":{"Part0":{"Name":"Back","__type":"InstanceRef"},"Part1":{"Name":"LeftUpper","__type":"InstanceRef"},"Enabled":true},"Name":"WeldConstraintPart2","ClassName":"WeldConstraint"},{"Children":[{"Children":[],"Properties":{"Enabled":false},"Name":"LocalScript","ClassName":"LocalScript"}],"Properties":{"C1":{"Components":[0.5,0,0,1,0,0,0,1,0,0,0,1],"__type":"CFrame"},"Part1":{"Name":"Back","__type":"InstanceRef"},"Enabled":true,"C0":{"Components":[0,-1.0499999523162842,0,-4.354505378501017e-8,-3.809698778667325e-9,1,-0.08715574443340302,0.9961947202682495,-0,-0.9961947202682495,-0.08715574443340302,-4.371138828673793e-8],"__type":"CFrame"}},"Name":"Motor6D","ClassName":"Motor6D"},{"Children":[],"Properties":{"Part0":{"Name":"Back","__type":"InstanceRef"},"Part1":{"Name":"LeftLower","__type":"InstanceRef"},"Enabled":true},"Name":"WeldConstraintPart1","ClassName":"WeldConstraint"},{"Children":[{"Children":[],"Properties":{"Transparency":0,"Face":{"__type":"EnumItem","EnumType":"NormalId","Name":"Front"},"Texture":"rbxassetid://106536900989726"},"Name":"Pants","ClassName":"Decal"},{"Children":[],"Properties":{"Scale":{"Y":0.777999997138977,"__type":"Vector3","X":0.777999997138977,"Z":0.800000011920929},"MeshId":"rbxassetid://122964280858656","MeshType":{"__type":"EnumItem","EnumType":"MeshType","Name":"FileMesh"}},"Name":"Mesh","ClassName":"SpecialMesh"},{"Children":[],"Properties":{"Transparency":0,"Face":{"__type":"EnumItem","EnumType":"NormalId","Name":"Front"},"Texture":"rbxassetid://132155326"},"Name":"Color","ClassName":"Decal"}],"Properties":{"RootPriority":0,"CanQuery":true,"CanCollide":true,"Color":{"B":0.6470588445663452,"__type":"Color3","G":0.6352941393852234,"R":0.6392157077789307},"CFrame":{"Components":[-11.112558364868164,1.6532795429229737,57.74300003051758,0,0.08715573698282242,-0.9961947202682495,0,0.9961947202682495,0.08715573698282242,1,0,0],"__type":"CFrame"},"CanTouch":true,"Massless":true,"Reflectance":0,"Transparency":0,"Anchored":true,"Position":{"Y":1.6532795429229737,"__type":"Vector3","X":-11.112558364868164,"Z":57.74300003051758},"Orientation":{"Y":-90,"__type":"Vector3","X":-5,"Z":0},"Material":{"__type":"EnumItem","EnumType":"Material","Name":"Plastic"},"CastShadow":true,"Size":{"Y":0.9259999990463257,"__type":"Vector3","X":1.5490000247955323,"Z":1.5490000247955323}},"Name":"LeftLower","ClassName":"Part"},{"Children":[{"Children":[],"Properties":{"Transparency":0,"Face":{"__type":"EnumItem","EnumType":"NormalId","Name":"Front"},"Texture":"rbxassetid://132155326"},"Name":"Color","ClassName":"Decal"},{"Children":[],"Properties":{"Transparency":0,"Face":{"__type":"EnumItem","EnumType":"NormalId","Name":"Front"},"Texture":"rbxassetid://106536900989726"},"Name":"Pants","ClassName":"Decal"},{"Children":[],"Properties":{"Scale":{"Y":0.777999997138977,"__type":"Vector3","X":0.777999997138977,"Z":0.800000011920929},"MeshId":"rbxassetid://130985546090146","MeshType":{"__type":"EnumItem","EnumType":"MeshType","Name":"FileMesh"}},"Name":"Mesh","ClassName":"SpecialMesh"}],"Properties":{"RootPriority":0,"CanQuery":true,"CanCollide":true,"Color":{"B":0.6470588445663452,"__type":"Color3","G":0.6352941393852234,"R":0.6392157077789307},"CFrame":{"Components":[-10.106919288635254,1.6531083583831788,57.74300003051758,0,-0.08715573698282242,-0.9961947202682495,0,0.9961947202682495,-0.08715573698282242,1,0,0],"__type":"CFrame"},"CanTouch":true,"Massless":true,"Reflectance":0,"Transparency":0,"Anchored":true,"Position":{"Y":1.6531083583831788,"__type":"Vector3","X":-10.106919288635254,"Z":57.74300003051758},"Orientation":{"Y":-90,"__type":"Vector3","X":5,"Z":0},"Material":{"__type":"EnumItem","EnumType":"Material","Name":"Plastic"},"CastShadow":true,"Size":{"Y":0.9259999990463257,"__type":"Vector3","X":1.5490000247955323,"Z":1.5490000247955323}},"Name":"RightLower","ClassName":"Part"},{"Children":[{"Children":[],"Properties":{"Transparency":0,"Face":{"__type":"EnumItem","EnumType":"NormalId","Name":"Front"},"Texture":"rbxassetid://132155326"},"Name":"Color","ClassName":"Decal"},{"Children":[],"Properties":{"Scale":{"Y":0.777999997138977,"__type":"Vector3","X":0.777999997138977,"Z":0.800000011920929},"MeshId":"rbxassetid://92644414674973","MeshType":{"__type":"EnumItem","EnumType":"MeshType","Name":"FileMesh"}},"Name":"Mesh","ClassName":"SpecialMesh"},{"Children":[],"Properties":{"Transparency":0,"Face":{"__type":"EnumItem","EnumType":"NormalId","Name":"Front"},"Texture":"rbxassetid://115458648737508"},"Name":"Shirt","ClassName":"Decal"},{"Children":[],"Properties":{"Transparency":0,"Face":{"__type":"EnumItem","EnumType":"NormalId","Name":"Front"},"Texture":"rbxassetid://106536900989726"},"Name":"Pants","ClassName":"Decal"}],"Properties":{"RootPriority":0,"CanQuery":true,"CanCollide":true,"Color":{"B":0.6470588445663452,"__type":"Color3","G":0.6352941393852234,"R":0.6392157077789307},"CFrame":{"Components":[-11.040495872497559,2.4736130237579347,57.74300003051758,0,0.08715573698282242,-0.9961947202682495,0,0.9961947202682495,0.08715573698282242,1,0,0],"__type":"CFrame"},"CanTouch":true,"Massless":true,"Reflectance":0,"Transparency":0,"Anchored":true,"Position":{"Y":2.4736130237579347,"__type":"Vector3","X":-11.040495872497559,"Z":57.74300003051758},"Orientation":{"Y":-90,"__type":"Vector3","X":-5,"Z":0},"Material":{"__type":"EnumItem","EnumType":"Material","Name":"Plastic"},"CastShadow":true,"Size":{"Y":0.6240000128746033,"__type":"Vector3","X":1.5199999809265137,"Z":1.5199999809265137}},"Name":"LeftUpper","ClassName":"Part"},{"Children":[{"Children":[],"Properties":{"Transparency":0,"Face":{"__type":"EnumItem","EnumType":"NormalId","Name":"Front"},"Texture":"rbxassetid://132155326"},"Name":"Color","ClassName":"Decal"},{"Children":[],"Properties":{"Transparency":0,"Face":{"__type":"EnumItem","EnumType":"NormalId","Name":"Front"},"Texture":"rbxassetid://106536900989726"},"Name":"Pants","ClassName":"Decal"},{"Children":[],"Properties":{"Scale":{"Y":0.777999997138977,"__type":"Vector3","X":0.777999997138977,"Z":0.800000011920929},"MeshId":"rbxassetid://94114949165397","MeshType":{"__type":"EnumItem","EnumType":"MeshType","Name":"FileMesh"}},"Name":"Mesh","ClassName":"SpecialMesh"},{"Children":[],"Properties":{"Transparency":0,"Face":{"__type":"EnumItem","EnumType":"NormalId","Name":"Front"},"Texture":"rbxassetid://115458648737508"},"Name":"Shirt","ClassName":"Decal"}],"Properties":{"RootPriority":0,"CanQuery":true,"CanCollide":true,"Color":{"B":0.6470588445663452,"__type":"Color3","G":0.6352941393852234,"R":0.6392157077789307},"CFrame":{"Components":[-10.178706169128418,2.4736380577087404,57.74300003051758,0,-0.08715573698282242,-0.9961947202682495,0,0.9961947202682495,-0.08715573698282242,1,0,0],"__type":"CFrame"},"CanTouch":true,"Massless":true,"Reflectance":0,"Transparency":0,"Anchored":true,"Position":{"Y":2.4736380577087404,"__type":"Vector3","X":-10.178706169128418,"Z":57.74300003051758},"Orientation":{"Y":-90,"__type":"Vector3","X":5,"Z":0},"Material":{"__type":"EnumItem","EnumType":"Material","Name":"Plastic"},"CastShadow":true,"Size":{"Y":0.6240000128746033,"__type":"Vector3","X":1.5199999809265137,"Z":1.5199999809265137}},"Name":"RightUpper","ClassName":"Part"},{"Children":[],"Properties":{"Part0":{"Name":"Back","__type":"InstanceRef"},"Part1":{"Name":"RightLower","__type":"InstanceRef"},"Enabled":true},"Name":"WeldConstraintPart3","ClassName":"WeldConstraint"},{"Children":[],"Properties":{"Part0":{"Name":"Back","__type":"InstanceRef"},"Part1":{"Name":"RightUpper","__type":"InstanceRef"},"Enabled":true},"Name":"WeldConstraintPart4","ClassName":"WeldConstraint"}],"Properties":{"RootPriority":0,"CanQuery":true,"CanCollide":true,"Color":{"B":1,"__type":"Color3","G":1,"R":1},"CFrame":{"Components":[-10.599817276000977,1.9865138530731202,57.755863189697269,-0,0,1,-0.08715290576219559,0.9961959719657898,0,-0.9961949586868286,-0.08715284615755081,0],"__type":"CFrame"},"CanTouch":true,"Massless":true,"Reflectance":0,"Transparency":0,"Anchored":true,"Position":{"Y":1.9865138530731202,"__type":"Vector3","X":-10.599817276000977,"Z":57.755863189697269},"Orientation":{"Y":90,"__type":"Vector3","X":0,"Z":-5},"Material":{"__type":"EnumItem","EnumType":"Material","Name":"Plastic"},"CastShadow":true,"Size":{"Y":0.09283816069364548,"__type":"Vector3","X":0.09283816069364548,"Z":0.09283816069364548}},"Name":"Back","ClassName":"Part"},{"Children":[{"Children":[],"Properties":{"Scale":{"Y":1.0499999523162842,"__type":"Vector3","X":0.8500000238418579,"Z":0.8500000238418579},"MeshId":"rbxassetid://113889033216282","MeshType":{"__type":"EnumItem","EnumType":"MeshType","Name":"FileMesh"}},"Name":"Mesh","ClassName":"SpecialMesh"},{"Children":[],"Properties":{"C1":{"Components":[0,0,0,1,0,0,0,1,0,0,0,1],"__type":"CFrame"},"Part1":{"Name":"RLeg","__type":"InstanceRef"},"Enabled":true,"C0":{"Components":[0.07500000298023224,0.05000000074505806,0,-4.371138828673793e-8,0,-1,0,1,-0,1,-0,-4.371138828673793e-8],"__type":"CFrame"}},"Name":"Motor6D","ClassName":"Motor6D"},{"Children":[],"Properties":{"Transparency":0,"Face":{"__type":"EnumItem","EnumType":"NormalId","Name":"Front"},"Texture":"rbxassetid://106536900989726"},"Name":"Decal","ClassName":"Decal"}],"Properties":{"RootPriority":0,"CanQuery":true,"CanCollide":false,"Color":{"B":0.9725490212440491,"__type":"Color3","G":0.9725490212440491,"R":0.9725490212440491},"CFrame":{"Components":[-10.024820327758789,1.1613879203796387,57.40719985961914,0,0,-1,0,1,0,1,0,0],"__type":"CFrame"},"CanTouch":true,"Massless":true,"Reflectance":0,"Transparency":0,"Anchored":true,"Position":{"Y":1.1613879203796387,"__type":"Vector3","X":-10.024820327758789,"Z":57.40719985961914},"Orientation":{"Y":-90,"__type":"Vector3","X":0,"Z":0},"Material":{"__type":"EnumItem","EnumType":"Material","Name":"Plastic"},"CastShadow":true,"Size":{"Y":2,"__type":"Vector3","X":1,"Z":1}},"Name":"RLeg","ClassName":"Part"},{"Children":[{"Children":[],"Properties":{"C1":{"Components":[0,0,0,1,0,0,0,1,0,0,0,1],"__type":"CFrame"},"Part1":{"Name":"Torso","__type":"InstanceRef"},"Enabled":true,"C0":{"Components":[0,0,0,1,0,0,0,1,0,0,0,1],"__type":"CFrame"}},"Name":"Motor6D","ClassName":"Motor6D"},{"Children":[],"Properties":{"Transparency":0,"Face":{"__type":"EnumItem","EnumType":"NormalId","Name":"Left"},"Texture":"rbxassetid://106536900989726"},"Name":"Pants","ClassName":"Decal"},{"Children":[],"Properties":{"Scale":{"Y":1,"__type":"Vector3","X":1,"Z":1},"MeshId":"rbxassetid://79517594605642","MeshType":{"__type":"EnumItem","EnumType":"MeshType","Name":"FileMesh"}},"Name":"Mesh","ClassName":"SpecialMesh"},{"Children":[],"Properties":{"Transparency":0,"Face":{"__type":"EnumItem","EnumType":"NormalId","Name":"Top"},"Texture":"rbxassetid://115458648737508"},"Name":"Shirt","ClassName":"Decal"}],"Properties":{"RootPriority":0,"CanQuery":true,"CanCollide":true,"Color":{"B":0.9725490212440491,"__type":"Color3","G":0.9725490212440491,"R":0.9725490212440491},"CFrame":{"Components":[-10.610803604125977,3.061387300491333,57.447750091552737,1,0,0,0,1,0,0,0,1],"__type":"CFrame"},"CanTouch":true,"Massless":true,"Reflectance":0,"Transparency":0,"Anchored":true,"Position":{"Y":3.061387300491333,"__type":"Vector3","X":-10.610803604125977,"Z":57.447750091552737},"Orientation":{"Y":0,"__type":"Vector3","X":0,"Z":0},"Material":{"__type":"EnumItem","EnumType":"Material","Name":"Plastic"},"CastShadow":true,"Size":{"Y":2,"__type":"Vector3","X":2.200000047683716,"Z":1.093000054359436}},"Name":"Torso","ClassName":"Part"},{"Children":[{"Children":[],"Properties":{"C1":{"Components":[0,0,0,1,0,0,0,1,0,0,0,1],"__type":"CFrame"},"Part1":{"Name":"LLeg","__type":"InstanceRef"},"Enabled":true,"C0":{"Components":[-0.07500000298023224,0.05000000074505806,0,-4.371138828673793e-8,0,-1,0,1,-0,1,-0,-4.371138828673793e-8],"__type":"CFrame"}},"Name":"Motor6D","ClassName":"Motor6D"},{"Children":[],"Properties":{"Scale":{"Y":1.0499999523162842,"__type":"Vector3","X":0.8500000238418579,"Z":0.8500000238418579},"MeshId":"rbxassetid://96597411340056","MeshType":{"__type":"EnumItem","EnumType":"MeshType","Name":"FileMesh"}},"Name":"Mesh","ClassName":"SpecialMesh"},{"Children":[],"Properties":{"Transparency":0,"Face":{"__type":"EnumItem","EnumType":"NormalId","Name":"Front"},"Texture":"rbxassetid://106536900989726"},"Name":"Decal","ClassName":"Decal"}],"Properties":{"RootPriority":0,"CanQuery":true,"CanCollide":false,"Color":{"B":0.9725490212440491,"__type":"Color3","G":0.9725490212440491,"R":0.9725490212440491},"CFrame":{"Components":[-11.174814224243164,1.1613879203796387,57.40719985961914,0,0,-1,0,1,0,1,0,0],"__type":"CFrame"},"CanTouch":true,"Massless":true,"Reflectance":0,"Transparency":0,"Anchored":true,"Position":{"Y":1.1613879203796387,"__type":"Vector3","X":-11.174814224243164,"Z":57.40719985961914},"Orientation":{"Y":-90,"__type":"Vector3","X":0,"Z":0},"Material":{"__type":"EnumItem","EnumType":"Material","Name":"Plastic"},"CastShadow":true,"Size":{"Y":2,"__type":"Vector3","X":1,"Z":1}},"Name":"LLeg","ClassName":"Part"}],"Properties":[],"Name":"Parts","ClassName":"Model"}]]
local bustJsonString = [[{"Children":[{"Children":[{"Children":[],"Properties":{"Scale":{"Y":0.569,"__type":"Vector3","X":0.569,"Z":0.569},"MeshId":"rbxassetid://137556772426221","MeshType":{"__type":"EnumItem","EnumType":"MeshType","Name":"FileMesh"},"TextureId":""},"Name":"Mesh","ClassName":"SpecialMesh"},{"Children":[{"Children":[],"Properties":{"Scale":{"Y":0.569,"__type":"Vector3","X":0.569,"Z":0.569},"MeshId":"rbxassetid://102322505864476","MeshType":{"__type":"EnumItem","EnumType":"MeshType","Name":"FileMesh"},"TextureId":""},"Name":"Mesh","ClassName":"SpecialMesh"}],"Properties":{"Reflectance":0,"Massless":true,"Color":{"B":0.6470588445663452,"__type":"Color3","G":0.6352941393852234,"R":0.6392157077789307},"Anchored":true,"Material":{"__type":"EnumItem","EnumType":"Material","Name":"Plastic"},"Size":{"Y":1.386526107788086,"__type":"Vector3","X":1.5822805166244507,"Z":1.2947300672531129},"CanCollide":true,"RootPriority":0,"CanTouch":true,"Transparency":0,"CanQuery":true,"Position":{"Y":0.7107750773429871,"__type":"Vector3","X":-17.16470718383789,"Z":31.837190628051759},"Orientation":{"Y":0,"__type":"Vector3","X":0,"Z":0},"CFrame":{"Components":[-17.16470718383789,0.7107750773429871,31.837190628051759,1,-2.4492937051703359e-16,-1.9952029364752686e-23,2.4492937051703359e-16,1,1.6292068494294654e-7,-1.9952032520196307e-23,-1.6292068494294654e-7,1],"__type":"CFrame"},"CastShadow":true},"Name":"Part1","ClassName":"Part"},{"Children":[{"Children":[],"Properties":{"Scale":{"Y":0.569,"__type":"Vector3","X":0.569,"Z":0.569},"MeshId":"rbxassetid://110325136636161","MeshType":{"__type":"EnumItem","EnumType":"MeshType","Name":"FileMesh"},"TextureId":""},"Name":"Mesh","ClassName":"SpecialMesh"}],"Properties":{"Reflectance":0,"Massless":true,"Color":{"B":0.6470588445663452,"__type":"Color3","G":0.6352941393852234,"R":0.6392157077789307},"Anchored":true,"Material":{"__type":"EnumItem","EnumType":"Material","Name":"Plastic"},"Size":{"Y":1.386526107788086,"__type":"Vector3","X":1.5822807550430298,"Z":1.2947300672531129},"CanCollide":true,"RootPriority":0,"CanTouch":true,"Transparency":0,"CanQuery":true,"Position":{"Y":0.719771683216095,"__type":"Vector3","X":-17.161455154418947,"Z":31.04874610900879},"Orientation":{"Y":0,"__type":"Vector3","X":0,"Z":0},"CFrame":{"Components":[-17.161455154418947,0.719771683216095,31.04874610900879,1,-2.4492937051703359e-16,-1.9952029364752686e-23,2.4492937051703359e-16,1,1.6292068494294654e-7,-1.9952032520196307e-23,-1.6292068494294654e-7,1],"__type":"CFrame"},"CastShadow":true},"Name":"Part2","ClassName":"Part"},{"Children":[],"Properties":{"Part0":{"Name":"Cloth","__type":"InstanceRef"},"Part1":{"Name":"Part2","__type":"InstanceRef"},"Enabled":true},"Name":"WeldConstraint","ClassName":"WeldConstraint"},{"Children":[],"Properties":{"Part0":{"Name":"Cloth","__type":"InstanceRef"},"Part1":{"Name":"Part1","__type":"InstanceRef"},"Enabled":true},"Name":"WeldConstraint","ClassName":"WeldConstraint"},{"Children":[],"Properties":{"C1":{"Components":[0.44999998807907107,-0.25999999046325686,0,1,0,0,0,1,-4.656612873077393e-10,0,4.656612873077393e-10,1],"__type":"CFrame"},"Part1":{"Name":"Cloth","__type":"InstanceRef"},"Enabled":true,"C0":{"Components":[0,0,0,-4.371138828673793e-8,0,-1,0,1,-0,1,-0,-4.371138828673793e-8],"__type":"CFrame"}},"Name":"Motor6D","ClassName":"Motor6D"}],"Properties":{"Reflectance":0,"Massless":true,"Color":{"B":0.6470588445663452,"__type":"Color3","G":0.6352941393852234,"R":0.6392157077789307},"Anchored":true,"Material":{"__type":"EnumItem","EnumType":"Material","Name":"Plastic"},"Size":{"Y":1.4419279098510743,"__type":"Vector3","X":1.6369144916534424,"Z":2.1314291954040529},"Part1":{"Name":"Part1","__type":"InstanceRef"},"CanCollide":true,"RootPriority":0,"CanTouch":true,"Transparency":0.019999999552965165,"CanQuery":true,"Position":{"Y":0.7209643721580505,"__type":"Vector3","X":-17.162267684936525,"Z":31.445749282836915},"Orientation":{"Y":0,"__type":"Vector3","X":0,"Z":0},"CFrame":{"Components":[-17.162267684936525,0.7209643721580505,31.445749282836915,1,-2.4492937051703359e-16,-1.9952029364752686e-23,2.4492937051703359e-16,1,1.6292068494294654e-7,-1.9952032520196307e-23,-1.6292068494294654e-7,1],"__type":"CFrame"},"CastShadow":true},"Name":"Cloth","ClassName":"Part"}],"Properties":[],"Name":"Cloth","ClassName":"Model"}]]

local activePlayers = {}

-- ==========================================
-- 3. PHYSICS (SPRINGS) + VISIBILITY
-- ==========================================
local function updateSpring(spring, targetForce, dt, stiffness, damping, maxDev, softness)
	local force = -stiffness * spring.pos - damping * spring.vel + targetForce
	spring.vel = spring.vel + force * dt
	spring.pos = spring.pos + spring.vel * dt
	local normalized = (spring.pos / maxDev) * softness
	local softPos = (math.tanh(normalized) / math.tanh(softness)) * maxDev
	spring.pos = softPos
	return softPos
end

local function isVisible(targetCharacter, targetPos)
	local camera = workspace.CurrentCamera
	if not camera then return false end
	local cameraPos = camera.CFrame.Position
	local dir = targetPos - cameraPos
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	local ignoreList = { targetCharacter }
	if LocalPlayer.Character then table.insert(ignoreList, LocalPlayer.Character) end
	rayParams.FilterDescendantsInstances = ignoreList
	local rayResult = workspace:Raycast(cameraPos, dir, rayParams)
	return rayResult == nil
end

-- ==========================================
-- 4. DESERIALIZATION (UNIVERSAL, ISOLATED)
-- ==========================================
local function deserializeTree(data, cframeQueue)
	local success, instance = pcall(function() return Instance.new(data.ClassName) end)
	if not success or not instance then return nil end
	instance.Name = data.Name

	for propName, valData in pairs(data.Properties) do
		if propName ~= "CFrame" and propName ~= "Position" and propName ~= "Orientation" then
			pcall(function()
				if type(valData) == "table" and valData.__type then
					local t = valData.__type
					if t == "Vector3" then
						instance[propName] = Vector3.new(valData.X, valData.Y, valData.Z)
					elseif t == "Color3" then
						instance[propName] = Color3.new(valData.R, valData.G, valData.B)
					elseif t == "EnumItem" then
						if Enum[valData.EnumType] and Enum[valData.EnumType][valData.Name] then
							instance[propName] = Enum[valData.EnumType][valData.Name]
						end
					end
				elseif (propName == "MeshId" or propName == "TextureId" or propName == "Texture") and type(valData) == "string" and valData ~= "" then
					local digits = string.match(valData, "%d+")
					instance[propName] = digits and ("rbxassetid://" .. digits) or valData
				else
					instance[propName] = valData
				end
			end)
		end
	end

	if instance:IsA("Decal") then
		if instance.Name == "Shirt" then
			pcall(function() instance.ZIndex = 3 end)
		elseif instance.Name == "Pants" then
			pcall(function() instance.ZIndex = 2 end)
		elseif instance.Name == "Color" then
			pcall(function() instance.ZIndex = 1 end)
		end
	end
	
	pcall(function() instance.Anchored = false end)

	if data.Properties["CFrame"] then
		table.insert(cframeQueue, {
			Instance = instance,
			CFrame = CFrame.new(unpack(data.Properties["CFrame"].Components)),
			DataName = data.Name
		})
	end

	for _, childData in ipairs(data.Children or {}) do
		local childInstance = deserializeTree(childData, cframeQueue)
		if childInstance then childInstance.Parent = instance end
	end
	return instance
end

local function deserializeModel(jsonStr)
	local success, data = pcall(function() return HttpService:JSONDecode(jsonStr) end)
	if not success or not data then return nil end

	local cframeQueue = {}
	local root = deserializeTree(data, cframeQueue)
	if not root then return nil end

	root.Parent = ReplicatedStorage -- Isolate from physics and welding

	local function findPart(name, rootInst)
		if rootInst.Name == name then return rootInst end
		for _, d in ipairs(rootInst:GetDescendants()) do
			if d.Name == name then return d end
		end
		return nil
	end

	local function restoreLinks(inst, dat)
		if dat.Properties then
			for prop, val in pairs(dat.Properties) do
				if (prop == "Part0" or prop == "Part1") and type(val) == "table" and val.__type == "InstanceRef" then
					local target = findPart(val.Name, root)
					if target then pcall(function() inst[prop] = target end) end
				end
			end
		end
		for i, childInst in ipairs(inst:GetChildren()) do
			if dat.Children and dat.Children[i] then restoreLinks(childInst, dat.Children[i]) end
		end
	end
	restoreLinks(root, data)

	for _, item in ipairs(cframeQueue) do
		pcall(function() item.Instance.CFrame = item.CFrame end)
	end

	return root
end

local cachedBodyModel = nil
local cachedBustModel = nil

local function getBodyModel()
	if not cachedBodyModel then cachedBodyModel = deserializeModel(bodyJsonString) end
	return cachedBodyModel
end

local function getBustModel()
	if not cachedBustModel then cachedBustModel = deserializeModel(bustJsonString) end
	return cachedBustModel
end

-- ==========================================
-- 5. UNIFIED BODY CHECK (TARGET PLAYERS ONLY)
-- ==========================================
local function waitForTargetMesh(character, timeout)
	local startTime = tick()
	repeat
		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("CharacterMesh") and child.BodyPart == Enum.BodyPart.Torso then
				if string.find(child.MeshId, TARGET_MESH_ID) then
					return true
				end
			end
		end
		task.wait(0.3)
	until (tick() - startTime) > timeout
	return false
end

-- ==========================================
-- 6. CLOTHING TEXTURES (CONTENT-SAFE + CACHES)
-- ==========================================
local function contentToString(value)
	if type(value) == "string" then return value end
	if value == nil then return "" end
	local ok, result = pcall(function() return value.Value end)
	if ok and type(result) == "string" then return result end
	ok, result = pcall(function() return tostring(value) end)
	if ok and type(result) == "string" and not string.find(result, "SourceType", 1, true) then
		return result
	end
	return ""
end

local function isBlacklisted(templateUrl)
	if not templateUrl or templateUrl == "" then return false end
	local idFromUrl = string.match(templateUrl, "%d+")
	if not idFromUrl then return false end
	for _, blackId in ipairs(BLACKLISTED_SHIRTS) do
		local cleanBlackId = string.match(tostring(blackId), "%d+")
		if cleanBlackId and idFromUrl == cleanBlackId then return true end
	end
	return false
end

local function getShirtTextureIdForBust(character)
	local shirt = character:FindFirstChildOfClass("Shirt")
	if shirt then
		local template = contentToString(shirt.ShirtTemplate)
		if template ~= "" and not isBlacklisted(template) then
			local assetId = string.match(template, "%d+")
			if assetId then return "rbxassetid://" .. assetId end
		end
	end
	return ""
end

local function getShirtTextureIdRaw(character)
	local shirt = character:FindFirstChildOfClass("Shirt")
	if shirt then
		local template = contentToString(shirt.ShirtTemplate)
		if template ~= "" then
			local assetId = string.match(template, "%d+")
			if assetId then return "rbxassetid://" .. assetId end
		end
	end
	return ""
end

local function getPantsTextureId(character)
	local pants = character:FindFirstChildOfClass("Pants")
	if pants then
		local template = contentToString(pants.PantsTemplate)
		if template ~= "" then
			local assetId = string.match(template, "%d+")
			if assetId then return "rbxassetid://" .. assetId end
		end
	end
	return ""
end

local function getActiveClothingTemplate(character)
	local shirtTex = getShirtTextureIdForBust(character)
	if shirtTex ~= "" then return shirtTex end
	return getPantsTextureId(character)
end

local function forceApplyTexture(clothClone, character)
	if not clothClone or not clothClone.Parent then return end
	local templateString = getActiveClothingTemplate(character)
	local lastTex = clothClone:GetAttribute("LastTex") or ""
	if templateString ~= "" then
		local assetId = string.match(templateString, "%d+")
		lastTex = assetId and ("rbxassetid://" .. assetId) or templateString
		clothClone:SetAttribute("LastTex", lastTex)
	end
	for _, desc in ipairs(clothClone:GetDescendants()) do
		if desc:IsA("SpecialMesh") and desc.Parent == clothClone then
			if lastTex ~= "" then
				pcall(function() desc.TextureId = lastTex end)
			else
				pcall(function() desc.TextureId = "" end)
			end
		end
	end
end

-- ==========================================
-- 7. CLEANUP CHARACTER BEFORE APPLY / RESTORE
-- ==========================================
local function cleanupCharacter(character)
	if not character then return end
	local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
	local leftLeg = character:FindFirstChild("Left Leg") or character:FindFirstChild("LeftUpperLeg")
	local rightLeg = character:FindFirstChild("Right Leg") or character:FindFirstChild("RightUpperLeg")
	if torso then
		for _, name in ipairs({"Cloth", "Back", "Torso"}) do
			local obj = torso:FindFirstChild(name)
			if obj then obj:Destroy() end
		end
	end
	if leftLeg then
		local o = leftLeg:FindFirstChild("LLeg")
		if o then o:Destroy() end
	end
	if rightLeg then
		local o = rightLeg:FindFirstChild("RLeg")
		if o then o:Destroy() end
	end
end

-- ==========================================
-- 8. MAIN FUNCTION: BODY + BUTT + BUST (CHECKED)
-- ==========================================
local function setupUltimateCharacter(character, player)
	if not scriptActive then return end
	
	local torso = character:WaitForChild("Torso", 10) or character:WaitForChild("UpperTorso", 10)
	local leftLeg = character:WaitForChild("Left Leg", 5) or character:WaitForChild("LeftUpperLeg", 5)
	local rightLeg = character:WaitForChild("Right Leg", 5) or character:WaitForChild("RightUpperLeg", 5)
	if not torso then return end

	if not waitForTargetMesh(character, 7) then return end
	if not scriptActive then return end

	cleanupCharacter(character)

	local originalTorsoColor = torso.Color
	local originalLeftLegColor = leftLeg and leftLeg.Color or torso.Color
	local originalRightLegColor = rightLeg and rightLeg.Color or torso.Color

	local buttMotor = nil
	local bodyParts = {}

	-- 8.1. ATTACH BODY
	local customBodyAttached = false
	local bodyTemplate = getBodyModel()
	if bodyTemplate then
		local bodyClone = bodyTemplate:Clone()

		local cLLeg = bodyClone:FindFirstChild("LLeg")
		local cRLeg = bodyClone:FindFirstChild("RLeg")
		local cTorso = bodyClone:FindFirstChild("Torso")
		local cBack = bodyClone:FindFirstChild("Back")

		if cLLeg and leftLeg then
			cLLeg.Parent = leftLeg
			cLLeg.CanCollide = false
			cLLeg.Massless = true
			cLLeg.Color = originalLeftLegColor
			table.insert(bodyParts, cLLeg)
			local m = cLLeg:FindFirstChildOfClass("Motor6D")
			if m then
				m.Part0 = leftLeg
				m.Part1 = cLLeg
				m.C0 = CFrame.new(-0.075, 0.05, 0) * CFrame.Angles(0, math.rad(-90), 0)
			end
		end
		if cRLeg and rightLeg then
			cRLeg.Parent = rightLeg
			cRLeg.CanCollide = false
			cRLeg.Massless = true
			cRLeg.Color = originalRightLegColor
			table.insert(bodyParts, cRLeg)
			local m = cRLeg:FindFirstChildOfClass("Motor6D")
			if m then
				m.Part0 = rightLeg
				m.Part1 = cRLeg
				m.C0 = CFrame.new(0.075, 0.05, 0) * CFrame.Angles(0, math.rad(-90), 0)
			end
		end
		if cTorso and torso then
			cTorso.Parent = torso
			cTorso.Color = originalTorsoColor
			cTorso.CanCollide = false
			cTorso.Massless = true
			table.insert(bodyParts, cTorso)
			customBodyAttached = true
			local m = cTorso:FindFirstChildOfClass("Motor6D")
			if m then
				m.Part0 = torso
				m.Part1 = cTorso
			end
		end
		if cBack and torso then
			cBack.Parent = torso
			cBack.CanCollide = false
			cBack.CanTouch = false
			cBack.CanQuery = false
			cBack.Massless = true
			table.insert(bodyParts, cBack)
			
			for _, desc in ipairs(cBack:GetDescendants()) do
				if desc:IsA("BasePart") then
					desc.CanCollide = false
					desc.CanTouch = false
					desc.CanQuery = false
					desc.Massless = true
					
					if desc.Name == "LeftLower" then
						desc.Color = originalLeftLegColor
					elseif desc.Name == "RightLower" then
						desc.Color = originalRightLegColor
					else
						desc.Color = originalTorsoColor
					end
				end
			end
			
			buttMotor = cBack:FindFirstChildOfClass("Motor6D")
			if buttMotor then
				buttMotor.Part0 = torso
				buttMotor.Part1 = cBack
				buttMotor.C0 = BUTT_BASE_C0
				buttMotor.C1 = BUTT_BASE_C1
			end
		end

		bodyClone:Destroy()
	end

	-- 8.2. HIDE ORIGINAL UNCONDITIONALLY
	if customBodyAttached then
		local originalParts = { torso, leftLeg, rightLeg }
		for _, origPart in ipairs(originalParts) do
			if origPart then
				pcall(function() origPart.Transparency = 1 end)
				for _, child in ipairs(origPart:GetChildren()) do
					if child:IsA("Decal") then
						pcall(function() child.Transparency = 1 end)
					end
				end
			end
		end
	end

	-- 8.3. FORCE VISIBILITY OF CUSTOM PARTS (ONLY TRANSPARENCY)
	local function forceBodyVisibility()
		for _, rp in ipairs(bodyParts) do
			if rp and rp.Parent then
				pcall(function() rp.Transparency = 0 end)
				for _, desc in ipairs(rp:GetDescendants()) do
					if desc:IsA("BasePart") then
						pcall(function() desc.Transparency = 0 end)
					end
				end
			end
		end
	end
	forceBodyVisibility()

	-- 8.4. REGISTER IN activePlayers IMMEDIATELY
	local data = activePlayers[player]
	if not data then
		data = {
			torso = torso,
			origTorso = torso,
			origLeftLeg = leftLeg,
			origRightLeg = rightLeg,
			customBodyParts = bodyParts,
			bustMotor = nil,
			buttMotor = buttMotor,
			cloth = nil,
			bustPrevCF = nil, bustPrevVel = Vector3.zero,
			sPitch = {pos = 0, vel = 0}, sYaw = {pos = 0, vel = 0}, sRoll = {pos = 0, vel = 0},
			buttPrevCF = nil, buttPrevVel = Vector3.zero,
			bPitch = {pos = 0, vel = 0}, bYaw = {pos = 0, vel = 0}, bRoll = {pos = 0, vel = 0}, bYZ = {pos = 0, vel = 0}
		}
		activePlayers[player] = data
	else
		data.torso = torso
		data.origTorso = torso
		data.origLeftLeg = leftLeg
		data.origRightLeg = rightLeg
		data.customBodyParts = bodyParts
		data.buttMotor = buttMotor
		data.buttPrevCF = nil
		data.buttPrevVel = Vector3.zero
	end

	-- 8.5. BUST
	local clothClone = nil
	local bustTemplate = getBustModel()
	if bustTemplate then
		local innerCloth = bustTemplate:FindFirstChild("Cloth")
		if innerCloth then
			clothClone = innerCloth:Clone()
			clothClone.Parent = torso
			clothClone.CanCollide = false
			clothClone.CanTouch = false
			clothClone.CanQuery = false
			clothClone.Massless = true
			clothClone.Color = originalTorsoColor

			local p1 = clothClone:FindFirstChild("Part1")
			local p2 = clothClone:FindFirstChild("Part2")
			if p1 and p1:IsA("BasePart") then
				p1.CanCollide = false; p1.CanTouch = false; p1.CanQuery = false
				p1.Massless = true; p1.Color = originalTorsoColor; p1.Anchored = false
			end
			if p2 and p2:IsA("BasePart") then
				p2.CanCollide = false; p2.CanTouch = false; p2.CanQuery = false
				p2.Massless = true; p2.Color = originalTorsoColor; p2.Anchored = false
			end

			for _, weld in ipairs(clothClone:GetChildren()) do
				if weld:IsA("WeldConstraint") then weld.Part0 = clothClone end
			end

			local bustMotor = clothClone:FindFirstChildOfClass("Motor6D")
			if bustMotor then
				bustMotor.Part0 = torso
				bustMotor.Part1 = clothClone
				bustMotor.C0 = BUST_BASE_C0
				bustMotor.C1 = CFrame.new(Settings.MOTOR_OFFSET_X, Settings.MOTOR_OFFSET_Y, Settings.MOTOR_OFFSET_Z)
				clothClone.Anchored = false
				data.bustMotor = bustMotor
				data.cloth = clothClone
				data.bustPrevCF = nil
				data.bustPrevVel = Vector3.zero
			end
		end
	end

	-- 8.6. UNIFIED SYNC OF CLOTHING, COLOR, ZINDEX
	local function applyBodyTextures()
		local shirtObj = character:FindFirstChildOfClass("Shirt")
		local pantsObj = character:FindFirstChildOfClass("Pants")
		
		local hasShirtObj = shirtObj ~= nil
		local hasPantsObj = pantsObj ~= nil
		
		local shirtTex = hasShirtObj and getShirtTextureIdRaw(character) or ""
		local pantsTex = hasPantsObj and getPantsTextureId(character) or ""

		for _, rootPart in ipairs(bodyParts) do
			if rootPart and rootPart.Parent then
				if rootPart.Name == "Torso" then
					pcall(function() rootPart.Color = originalTorsoColor end)
				elseif rootPart.Name == "LLeg" then
					pcall(function() rootPart.Color = originalLeftLegColor end)
				elseif rootPart.Name == "RLeg" then
					pcall(function() rootPart.Color = originalRightLegColor end)
				end
				
				for _, desc in ipairs(rootPart:GetDescendants()) do
					if desc:IsA("BasePart") then
						if desc.Name == "LeftLower" then
							pcall(function() desc.Color = originalLeftLegColor end)
						elseif desc.Name == "RightLower" then
							pcall(function() desc.Color = originalRightLegColor end)
						else
							pcall(function() desc.Color = originalTorsoColor end)
						end
					end
				end

				for _, desc in ipairs(rootPart:GetDescendants()) do
					if desc:IsA("Decal") then
						if desc.Name == "Shirt" then
							if hasShirtObj and shirtTex ~= "" then
								pcall(function() desc.Texture = shirtTex end)
								desc:SetAttribute("BaseTrans", 0)
								pcall(function() desc.Transparency = 0 end)
								pcall(function() desc.ZIndex = 3 end)
								
								local appliedId = string.match(contentToString(desc.Texture), "%d+")
								if appliedId == PANTIES_SHIRT_ID then
									pcall(function() desc.Color3 = BODY_MAX_WHITE end)
								else
									pcall(function() desc.Color3 = Color3.fromRGB(255, 255, 255) end)
								end
							else
								desc:SetAttribute("BaseTrans", 1)
								pcall(function() desc.Transparency = 1 end)
							end
							
						elseif desc.Name == "Pants" then
							if hasPantsObj and pantsTex ~= "" then
								pcall(function() desc.Texture = pantsTex end)
								desc:SetAttribute("BaseTrans", 0)
								pcall(function() desc.Transparency = 0 end)
								pcall(function() desc.ZIndex = 2 end)
							else
								desc:SetAttribute("BaseTrans", 1)
								pcall(function() desc.Transparency = 1 end)
							end
							
						elseif desc.Name == "Color" then
							local partColor = originalTorsoColor
							if desc.Parent and desc.Parent:IsA("BasePart") then
								if desc.Parent.Name == "LeftLower" then partColor = originalLeftLegColor
								elseif desc.Parent.Name == "RightLower" then partColor = originalRightLegColor
								end
							end
							pcall(function() desc.Color3 = partColor end)
							pcall(function() desc.ZIndex = 1 end)
							desc:SetAttribute("BaseTrans", 0)
							pcall(function() desc.Transparency = 0 end)
							
						elseif desc.Name == "Decal" then
							if hasPantsObj and pantsTex ~= "" then
								pcall(function() desc.Texture = pantsTex end)
								desc:SetAttribute("BaseTrans", 0)
								pcall(function() desc.Transparency = 0 end)
							else
								desc:SetAttribute("BaseTrans", 1)
								pcall(function() desc.Transparency = 1 end)
							end
						end
					end
				end
			end
		end
	end

	local function refreshAllTextures()
		if not scriptActive then return end
		forceBodyVisibility()
		applyBodyTextures()
		if clothClone and clothClone.Parent then
			forceApplyTexture(clothClone, character)
			local templateString = getActiveClothingTemplate(character)
			if templateString == "" then
				for _, desc in ipairs(clothClone:GetDescendants()) do
					if desc:IsA("SpecialMesh") then
						pcall(function() desc.TextureId = "" end)
					end
				end
			end
		end
	end
	refreshAllTextures()

	local function bindClothingEvents(item)
		if item:IsA("Shirt") then
			item:GetPropertyChangedSignal("ShirtTemplate"):Connect(refreshAllTextures)
			refreshAllTextures()
		elseif item:IsA("Pants") then
			item:GetPropertyChangedSignal("PantsTemplate"):Connect(refreshAllTextures)
			refreshAllTextures()
		end
	end
	for _, child in ipairs(character:GetChildren()) do bindClothingEvents(child) end
	character.ChildAdded:Connect(bindClothingEvents)
	character.ChildRemoved:Connect(function(child)
		if child:IsA("Shirt") or child:IsA("Pants") then
			task.delay(0.1, refreshAllTextures)
		end
	end)
	
	task.spawn(function()
		local checkDelays = {0.5, 1, 2, 4, 7}
		for _, delayTime in ipairs(checkDelays) do
			task.wait(delayTime)
			if not scriptActive then break end
			local alive = false
			for _, rp in ipairs(bodyParts) do
				if rp and rp.Parent then alive = true break end
			end
			if (clothClone and clothClone.Parent) or alive then
				refreshAllTextures()
			else
				break
			end
		end
	end)
end

local function rebuildAll()
	activePlayers = {}
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Character then
			cleanupCharacter(plr.Character)
			task.spawn(function() setupUltimateCharacter(plr.Character, plr) end)
		end
	end
end

-- ==========================================
-- 9. UI (COREGUI) — BUST, BUTT, BODY SETTINGS
-- ==========================================
local uiRefreshCallbacks = {}
local screenGui = nil

local function applyPreset(presetTable)
	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
	
	-- Список настроек видимости, которые ПРЕСЕТЫ И СБРОС НЕ ДОЛЖНЫ ТРОГАТЬ
	local ignoredKeys = {
		FORCE_BODY_FIRST_PERSON = true,
		FORCE_FIRST_PERSON_VISIBILITY = true,
		HIDE_ALL_BUSTS = true,
		LOCAL_PLAYER_ONLY = true,
	}

	for key, targetVal in pairs(presetTable) do
		-- Если ключ в списке игнорируемых, пропускаем его и сохраняем выбор игрока
		if ignoredKeys[key] then 
			continue 
		end

		if type(targetVal) == "number" then
			local startVal = Settings[key] or targetVal
			local valueObj = Instance.new("NumberValue")
			valueObj.Value = startVal
			valueObj:GetPropertyChangedSignal("Value"):Connect(function()
				Settings[key] = valueObj.Value
				for _, cb in ipairs(uiRefreshCallbacks) do cb() end
			end)
			local tween = TweenService:Create(valueObj, tweenInfo, { Value = targetVal })
			tween:Play()
			tween.Completed:Connect(function() valueObj:Destroy() end)
		else
			Settings[key] = targetVal
		end
	end
	for _, cb in ipairs(uiRefreshCallbacks) do cb() end
end

-- ==========================================
-- 10. DESTROY FUNCTION (FULL CLEANUP)
-- ==========================================
local function destroyEverything()
	scriptActive = false
	pcall(function() RunService:UnbindFromRenderStep("BustPhysicsFirstPersonVisibility") end)
	
	-- 1. Clean up all players and restore original transparency
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Character then
			cleanupCharacter(plr.Character)
			
			local char = plr.Character
			local origParts = {
				char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"),
				char:FindFirstChild("Left Leg") or char:FindFirstChild("LeftUpperLeg"),
				char:FindFirstChild("Right Leg") or char:FindFirstChild("RightUpperLeg")
			}
			
			for _, part in ipairs(origParts) do
				if part then
					pcall(function() part.Transparency = 0 end)
					for _, child in ipairs(part:GetChildren()) do
						if child:IsA("Decal") then
							pcall(function() child.Transparency = 0 end)
						end
					end
				end
			end
		end
	end
	
	-- 2. Clear active players table
	activePlayers = {}
	
	-- 3. Destroy UI
	if screenGui then
		screenGui:Destroy()
		screenGui = nil
	end
	
	print("[Bust Physics ".. version .."] Destroyed: All custom parts removed, original body restored, physics stopped, UI deleted")
end

local function createSettingsGui()
	local oldGui = PlayerGui:FindFirstChild("BustPhysicsGui")
	if oldGui then oldGui:Destroy() end
	uiRefreshCallbacks = {}

	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "BustPhysicsGui"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = PlayerGui

	local cameraLockModal = Instance.new("TextButton")
	cameraLockModal.Name = "CameraLockModal"
	cameraLockModal.Size = UDim2.new(0, 0, 0, 0)
	cameraLockModal.BackgroundTransparency = 1
	cameraLockModal.Text = ""
	cameraLockModal.Modal = false
	cameraLockModal.Parent = screenGui

	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	mainFrame.Size = UDim2.new(0, 220, 0, 410)
	mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	mainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
	mainFrame.BorderSizePixel = 0
	mainFrame.ClipsDescendants = true
	mainFrame.Active = true
	mainFrame.Parent = screenGui

	local uiScale = Instance.new("UIScale")
	uiScale.Parent = mainFrame
	local function updateAdaptiveScale()
		local camera = workspace.CurrentCamera
		if not camera then return end
		uiScale.Scale = math.clamp(camera.ViewportSize.Y / 480, 0.45, 1.25)
	end
	if workspace.CurrentCamera then
		workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateAdaptiveScale)
		updateAdaptiveScale()
	end

	Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
	local mainStroke = Instance.new("UIStroke", mainFrame)
	mainStroke.Color = Color3.fromRGB(65, 50, 75)

	local header = Instance.new("Frame")
	header.Name = "Header"
	header.Size = UDim2.new(1, 0, 0, 28)
	header.BackgroundColor3 = Color3.fromRGB(34, 28, 42)
	header.BorderSizePixel = 0
	header.Active = true
	header.Parent = mainFrame
	Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)
	local headerFix = Instance.new("Frame", header)
	headerFix.Size = UDim2.new(1, 0, 0, 8)
	headerFix.Position = UDim2.new(0, 0, 1, -8)
	headerFix.BackgroundColor3 = header.BackgroundColor3
	headerFix.BorderSizePixel = 0

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -30, 1, 0)
	titleLabel.Position = UDim2.new(0, 8, 0, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = ("Bust Physics ".. version)
	titleLabel.TextColor3 = Color3.fromRGB(245, 230, 255)
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 10
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = header

	local minimizeBtn = Instance.new("TextButton")
	minimizeBtn.Size = UDim2.new(0, 18, 0, 18)
	minimizeBtn.Position = UDim2.new(1, -22, 0.5, -9)
	minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 42, 60)
	minimizeBtn.Text = "—"
	minimizeBtn.TextColor3 = Color3.fromRGB(220, 200, 240)
	minimizeBtn.Font = Enum.Font.GothamBold
	minimizeBtn.TextSize = 10
	minimizeBtn.Parent = header
	Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 4)

	local openBtn = Instance.new("TextButton")
	openBtn.Name = "OpenButton"
	openBtn.AnchorPoint = Vector2.new(0, 0.5)
	openBtn.Size = UDim2.new(0, 32, 0, 32)
	openBtn.Position = UDim2.new(0, 12, 0.5, 0)
	openBtn.BackgroundColor3 = Color3.fromRGB(35, 28, 45)
	openBtn.Text = "⚙️"
	openBtn.TextSize = 14
	openBtn.Visible = false
	openBtn.Active = true
	openBtn.Parent = screenGui
	Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 16)
	local openStroke = Instance.new("UIStroke", openBtn)
	openStroke.Color = Color3.fromRGB(110, 75, 140)

	local tabBar = Instance.new("Frame")
	tabBar.Name = "TabBar"
	tabBar.Size = UDim2.new(1, -10, 0, 22)
	tabBar.Position = UDim2.new(0, 5, 0, 31)
	tabBar.BackgroundColor3 = Color3.fromRGB(28, 23, 35)
	tabBar.BorderSizePixel = 0
	tabBar.Parent = mainFrame
	Instance.new("UICorner", tabBar).CornerRadius = UDim.new(0, 4)
	local tabLayout = Instance.new("UIListLayout", tabBar)
	tabLayout.FillDirection = Enum.FillDirection.Horizontal

	local settingsTabBtn = Instance.new("TextButton")
	settingsTabBtn.Size = UDim2.new(0.5, 0, 1, 0)
	settingsTabBtn.BackgroundColor3 = Color3.fromRGB(60, 45, 80)
	settingsTabBtn.Text = "Settings"
	settingsTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	settingsTabBtn.Font = Enum.Font.GothamBold
	settingsTabBtn.TextSize = 9
	settingsTabBtn.Parent = tabBar
	Instance.new("UICorner", settingsTabBtn).CornerRadius = UDim.new(0, 4)

	local presetsTabBtn = Instance.new("TextButton")
	presetsTabBtn.Size = UDim2.new(0.5, 0, 1, 0)
	presetsTabBtn.BackgroundColor3 = Color3.fromRGB(35, 28, 45)
	presetsTabBtn.Text = "Presets"
	presetsTabBtn.TextColor3 = Color3.fromRGB(170, 155, 185)
	presetsTabBtn.Font = Enum.Font.GothamBold
	presetsTabBtn.TextSize = 9
	presetsTabBtn.Parent = tabBar
	Instance.new("UICorner", presetsTabBtn).CornerRadius = UDim.new(0, 4)

	local pagesContainer = Instance.new("Frame")
	pagesContainer.Size = UDim2.new(1, -10, 1, -58)
	pagesContainer.Position = UDim2.new(0, 5, 0, 56)
	pagesContainer.BackgroundTransparency = 1
	pagesContainer.Parent = mainFrame

	local settingsPage = Instance.new("ScrollingFrame")
	settingsPage.Size = UDim2.new(1, 0, 1, 0)
	settingsPage.BackgroundTransparency = 1
	settingsPage.ScrollBarThickness = 3
	settingsPage.ScrollBarImageColor3 = Color3.fromRGB(85, 65, 105)
	settingsPage.Active = true
	settingsPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
	settingsPage.CanvasSize = UDim2.new(0, 0, 0, 0)
	settingsPage.Visible = true
	settingsPage.Parent = pagesContainer
	local settingsList = Instance.new("UIListLayout", settingsPage)
	settingsList.SortOrder = Enum.SortOrder.LayoutOrder
	settingsList.Padding = UDim.new(0, 4)

	local presetsPage = Instance.new("ScrollingFrame")
	presetsPage.Size = UDim2.new(1, 0, 1, 0)
	presetsPage.BackgroundTransparency = 1
	presetsPage.ScrollBarThickness = 3
	presetsPage.ScrollBarImageColor3 = Color3.fromRGB(85, 65, 105)
	presetsPage.Active = true
	presetsPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
	presetsPage.CanvasSize = UDim2.new(0, 0, 0, 0)
	presetsPage.Visible = false
	presetsPage.Parent = pagesContainer
	local presetsList = Instance.new("UIListLayout", presetsPage)
	presetsList.SortOrder = Enum.SortOrder.LayoutOrder
	presetsList.Padding = UDim.new(0, 4)

	local function switchTab(tabName)
		settingsPage.Visible = (tabName == "Settings")
		presetsPage.Visible = (tabName == "Presets")
		settingsTabBtn.BackgroundColor3 = tabName == "Settings" and Color3.fromRGB(60, 45, 80) or Color3.fromRGB(35, 28, 45)
		settingsTabBtn.TextColor3 = tabName == "Settings" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(170, 155, 185)
		presetsTabBtn.BackgroundColor3 = tabName == "Presets" and Color3.fromRGB(60, 45, 80) or Color3.fromRGB(35, 28, 45)
		presetsTabBtn.TextColor3 = tabName == "Presets" and Color3.fromRGB(170, 155, 185)
	end
	settingsTabBtn.MouseButton1Click:Connect(function() switchTab("Settings") end)
	presetsTabBtn.MouseButton1Click:Connect(function() switchTab("Presets") end)

	-- Window dragging
	local dragging = false
	local dragStart, startPos
	header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = mainFrame.Position
			cameraLockModal.Modal = true
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = (input.Position - dragStart) / uiScale.Scale
			mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			cameraLockModal.Modal = false
		end
	end)

	-- Minimize / Expand
	local windowTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	minimizeBtn.MouseButton1Click:Connect(function()
		local tweenMain = TweenService:Create(mainFrame, windowTweenInfo, { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
		tweenMain:Play()
		tweenMain.Completed:Connect(function()
			mainFrame.Visible = false
			openBtn.Visible = true
			openBtn.Size = UDim2.new(0, 0, 0, 0)
			TweenService:Create(openBtn, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.new(0, 32, 0, 32) }):Play()
		end)
	end)
	openBtn.MouseButton1Click:Connect(function()
		openBtn.Visible = false
		mainFrame.Visible = true
		mainFrame.Size = UDim2.new(0, 0, 0, 0)
		mainFrame.BackgroundTransparency = 0
		TweenService:Create(mainFrame, windowTweenInfo, { Size = UDim2.new(0, 220, 0, 410) }):Play()
	end)
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
			screenGui.Enabled = not screenGui.Enabled
		end
	end)

	-- UI Helpers
	local layoutOrderCounter = 0
	local function createCollapsibleSection(parentPage, sectionTitle)
		layoutOrderCounter = layoutOrderCounter + 1
		local headerBtn = Instance.new("TextButton")
		headerBtn.Size = UDim2.new(1, -2, 0, 20)
		headerBtn.BackgroundColor3 = Color3.fromRGB(42, 32, 55)
		headerBtn.Text = "  ▼ " .. sectionTitle
		headerBtn.TextColor3 = Color3.fromRGB(235, 210, 255)
		headerBtn.Font = Enum.Font.GothamBold
		headerBtn.TextSize = 9
		headerBtn.TextXAlignment = Enum.TextXAlignment.Left
		headerBtn.LayoutOrder = layoutOrderCounter
		headerBtn.Parent = parentPage
		Instance.new("UICorner", headerBtn).CornerRadius = UDim.new(0, 4)

		local contentFrame = Instance.new("Frame")
		contentFrame.Size = UDim2.new(1, 0, 0, 0)
		contentFrame.AutomaticSize = Enum.AutomaticSize.Y
		contentFrame.BackgroundTransparency = 1
		contentFrame.Parent = parentPage
		layoutOrderCounter = layoutOrderCounter + 1
		contentFrame.LayoutOrder = layoutOrderCounter
		local contentList = Instance.new("UIListLayout", contentFrame)
		contentList.SortOrder = Enum.SortOrder.LayoutOrder
		contentList.Padding = UDim.new(0, 4)

		local isExpanded = true
		headerBtn.MouseButton1Click:Connect(function()
			isExpanded = not isExpanded
			contentFrame.Visible = isExpanded
			headerBtn.Text = (isExpanded and "  ▼ " or "  ► ") .. sectionTitle
		end)
		return contentFrame
	end

	local function addSliderSetting(container, labelText, key, minVal, maxVal, isDegree)
		layoutOrderCounter = layoutOrderCounter + 1
		local row = Instance.new("Frame")
		row.Size = UDim2.new(1, -2, 0, 30)
		row.BackgroundColor3 = Color3.fromRGB(30, 26, 36)
		row.LayoutOrder = layoutOrderCounter
		row.Parent = container
		Instance.new("UICorner", row).CornerRadius = UDim.new(0, 4)

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(0.65, 0, 0, 14)
		label.Position = UDim2.new(0, 6, 0, 2)
		label.BackgroundTransparency = 1
		label.Text = labelText
		label.TextColor3 = Color3.fromRGB(210, 200, 225)
		label.Font = Enum.Font.GothamMedium
		label.TextSize = 9
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Parent = row

		local valLabel = Instance.new("TextLabel")
		valLabel.Size = UDim2.new(0.3, 0, 0, 14)
		valLabel.Position = UDim2.new(0.65, -6, 0, 2)
		valLabel.BackgroundTransparency = 1
		valLabel.TextColor3 = Color3.fromRGB(230, 170, 255)
		valLabel.Font = Enum.Font.GothamBold
		valLabel.TextSize = 9
		valLabel.TextXAlignment = Enum.TextXAlignment.Right
		valLabel.Parent = row

		local track = Instance.new("Frame")
		track.Size = UDim2.new(1, -12, 0, 6)
		track.Position = UDim2.new(0, 6, 0, 18)
		track.BackgroundColor3 = Color3.fromRGB(44, 36, 54)
		track.BorderSizePixel = 0
		track.Parent = row
		Instance.new("UICorner", track).CornerRadius = UDim.new(0, 3)

		local fill = Instance.new("Frame")
		fill.Size = UDim2.new(0.5, 0, 1, 0)
		fill.BackgroundColor3 = Color3.fromRGB(160, 70, 190)
		fill.BorderSizePixel = 0
		fill.Parent = track
		Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 3)

		local function updateSliderVisual()
			local currVal = Settings[key]
			local alpha = math.clamp((currVal - minVal) / (maxVal - minVal), 0, 1)
			fill.Size = UDim2.new(alpha, 0, 1, 0)
			if isDegree then
				valLabel.Text = string.format("%.0f°", math.deg(currVal))
			else
				valLabel.Text = string.format("%.2f", currVal)
			end
		end

		local sliding = false
		local function updateFromInput(input)
			local posX = input.Position.X - track.AbsolutePosition.X
			local alpha = math.clamp(posX / track.AbsoluteSize.X, 0, 1)
			local newVal = minVal + alpha * (maxVal - minVal)
			if isDegree then
				Settings[key] = newVal
			else
				Settings[key] = math.floor(newVal * 100 + 0.5) / 100
			end
			updateSliderVisual()
		end

		track.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				sliding = true
				cameraLockModal.Modal = true
				updateFromInput(input)
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				updateFromInput(input)
			end
		end)
		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				sliding = false
				cameraLockModal.Modal = false
			end
		end)

		updateSliderVisual()
		table.insert(uiRefreshCallbacks, updateSliderVisual)
	end

	local function addToggleSetting(container, labelText, key)
		layoutOrderCounter = layoutOrderCounter + 1
		local row = Instance.new("Frame")
		row.Size = UDim2.new(1, -2, 0, 24)
		row.BackgroundColor3 = Color3.fromRGB(30, 26, 36)
		row.LayoutOrder = layoutOrderCounter
		row.Parent = container
		Instance.new("UICorner", row).CornerRadius = UDim.new(0, 4)

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(0.65, 0, 1, 0)
		label.Position = UDim2.new(0, 6, 0, 0)
		label.BackgroundTransparency = 1
		label.Text = labelText
		label.TextColor3 = Color3.fromRGB(210, 200, 225)
		label.Font = Enum.Font.GothamMedium
		label.TextSize = 9
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Parent = row

		local toggleBtn = Instance.new("TextButton")
		toggleBtn.Size = UDim2.new(0, 36, 0, 15)
		toggleBtn.Position = UDim2.new(1, -42, 0.5, -7)
		toggleBtn.Font = Enum.Font.GothamBold
		toggleBtn.TextSize = 8
		toggleBtn.Parent = row
		Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 7)

		local function updateState()
			local state = Settings[key]
			if state then
				toggleBtn.Text = "ON"
				toggleBtn.BackgroundColor3 = Color3.fromRGB(150, 60, 180)
				toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			else
				toggleBtn.Text = "OFF"
				toggleBtn.BackgroundColor3 = Color3.fromRGB(55, 50, 65)
				toggleBtn.TextColor3 = Color3.fromRGB(170, 160, 180)
			end
		end
		updateState()
		table.insert(uiRefreshCallbacks, updateState)
		toggleBtn.MouseButton1Click:Connect(function()
			Settings[key] = not Settings[key]
			updateState()
		end)
	end

	-- Section: Body (Special Fixes)
	local bodySection = createCollapsibleSection(settingsPage, "Body Settings")
	addToggleSetting(bodySection, "Show At 1st Person", "FORCE_BODY_FIRST_PERSON")
	
	layoutOrderCounter = layoutOrderCounter + 1
	local bodyNotice = Instance.new("TextLabel")
	bodyNotice.Size = UDim2.new(1, -6, 0, 28)
	bodyNotice.BackgroundTransparency = 1
	bodyNotice.Text = "⚠️ Fix for games with custom 1st person camera systems (e.g. Grace). Keep OFF in normal games to prevent body obscuring camera view."
	bodyNotice.TextColor3 = Color3.fromRGB(170, 155, 180)
	bodyNotice.Font = Enum.Font.Gotham
	bodyNotice.TextSize = 8
	bodyNotice.TextWrapped = true
	bodyNotice.TextXAlignment = Enum.TextXAlignment.Left
	bodyNotice.LayoutOrder = layoutOrderCounter
	bodyNotice.Parent = bodySection

	-- Section: Bust
	local bustSection = createCollapsibleSection(settingsPage, "Bust Physics")
	addToggleSetting(bustSection, "Hide All Busts", "HIDE_ALL_BUSTS")
	addToggleSetting(bustSection, "Local Player Only [Experemental]", "LOCAL_PLAYER_ONLY")
	addToggleSetting(bustSection, "1st Person Visible", "FORCE_FIRST_PERSON_VISIBILITY")
	addSliderSetting(bustSection, "Model Scale", "MODEL_SCALE", 0.1, 1.5)
	addSliderSetting(bustSection, "Motor Offset X", "MOTOR_OFFSET_X", -2.0, 2.0)
	addSliderSetting(bustSection, "Motor Offset Y", "MOTOR_OFFSET_Y", -2.0, 2.0)
	addSliderSetting(bustSection, "Stiffness", "STIFFNESS", 10, 500)
	addSliderSetting(bustSection, "Damping", "DAMPING", 0.1, 30)
	addSliderSetting(bustSection, "Rot. Inertia", "INERTIA_SCALE_ROT", 0, 10)
	addSliderSetting(bustSection, "Lin. Inertia", "INERTIA_SCALE_LIN", 0, 0.5)
	addSliderSetting(bustSection, "Max Deviation", "MAX_DEVIATION", math.rad(1), math.rad(60), true)
	addSliderSetting(bustSection, "Softness", "SOFTNESS", 0.01, 1)
	addSliderSetting(bustSection, "Bust Weight", "CLOTH_WEIGHT", -50, 20)

	-- Section: Butt
	local buttSection = createCollapsibleSection(settingsPage, "Butt Physics")
	addToggleSetting(buttSection, "Butt Physics Enabled", "BUTT_PHYSICS_ENABLED")
	addSliderSetting(buttSection, "Stiffness", "BUTT_STIFFNESS", 10, 500)
	addSliderSetting(buttSection, "Damping", "BUTT_DAMPING", 0.1, 30)
	addSliderSetting(buttSection, "Rot. Inertia", "BUTT_INERTIA_ROT", 0, 10)
	addSliderSetting(buttSection, "Lin. Inertia", "BUTT_INERTIA_LIN", 0, 0.5)
	addSliderSetting(buttSection, "Y-Z Inertia", "BUTT_INERTIA_Y_Z", 0, 0.5)
	addSliderSetting(buttSection, "Max Deviation", "BUTT_MAX_DEV", math.rad(1), math.rad(60), true)
	addSliderSetting(buttSection, "Softness", "BUTT_SOFTNESS", 0.01, 1)

	-- Buttons
	layoutOrderCounter = layoutOrderCounter + 1
	local rebuildBtn = Instance.new("TextButton")
	rebuildBtn.Size = UDim2.new(1, -2, 0, 22)
	rebuildBtn.BackgroundColor3 = Color3.fromRGB(160, 80, 40)
	rebuildBtn.Text = "Rebuild All"
	rebuildBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	rebuildBtn.Font = Enum.Font.GothamBold
	rebuildBtn.TextSize = 9
	rebuildBtn.LayoutOrder = layoutOrderCounter
	rebuildBtn.Parent = settingsPage
	Instance.new("UICorner", rebuildBtn).CornerRadius = UDim.new(0, 4)
	rebuildBtn.MouseButton1Click:Connect(function() rebuildAll() end)

	layoutOrderCounter = layoutOrderCounter + 1
	local resetBtn = Instance.new("TextButton")
	resetBtn.Size = UDim2.new(1, -2, 0, 22)
	resetBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 60)
	resetBtn.Text = "Reset Settings"
	resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	resetBtn.Font = Enum.Font.GothamBold
	resetBtn.TextSize = 9
	resetBtn.LayoutOrder = layoutOrderCounter
	resetBtn.Parent = settingsPage
	Instance.new("UICorner", resetBtn).CornerRadius = UDim.new(0, 4)
	resetBtn.MouseButton1Click:Connect(function() applyPreset(DEFAULT_SETTINGS) end)

	-- Destroy Button
	layoutOrderCounter = layoutOrderCounter + 1
	local destroyBtn = Instance.new("TextButton")
	destroyBtn.Size = UDim2.new(1, -2, 0, 22)
	destroyBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
	destroyBtn.Text = "Destroy Menu & Script"
	destroyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	destroyBtn.Font = Enum.Font.GothamBold
	destroyBtn.TextSize = 9
	destroyBtn.LayoutOrder = layoutOrderCounter
	destroyBtn.Parent = settingsPage
	Instance.new("UICorner", destroyBtn).CornerRadius = UDim.new(0, 4)
	destroyBtn.MouseButton1Click:Connect(function() destroyEverything() end)

	-- Presets
	local presetOrder = 0
	local function addPresetCard(nameText, descText, presetTable)
		presetOrder = presetOrder + 1
		local card = Instance.new("Frame")
		card.Size = UDim2.new(1, -2, 0, 44)
		card.BackgroundColor3 = Color3.fromRGB(30, 26, 36)
		card.LayoutOrder = presetOrder
		card.Parent = presetsPage
		Instance.new("UICorner", card).CornerRadius = UDim.new(0, 4)

		local cardTitle = Instance.new("TextLabel")
		cardTitle.Size = UDim2.new(0.6, 0, 0, 16)
		cardTitle.Position = UDim2.new(0, 8, 0, 4)
		cardTitle.BackgroundTransparency = 1
		cardTitle.Text = nameText
		cardTitle.TextColor3 = Color3.fromRGB(235, 220, 255)
		cardTitle.Font = Enum.Font.GothamBold
		cardTitle.TextSize = 10
		cardTitle.TextXAlignment = Enum.TextXAlignment.Left
		cardTitle.Parent = card

		local cardDesc = Instance.new("TextLabel")
		cardDesc.Size = UDim2.new(0.9, 0, 0, 18)
		cardDesc.Position = UDim2.new(0, 8, 0, 20)
		cardDesc.BackgroundTransparency = 1
		cardDesc.Text = descText
		cardDesc.TextColor3 = Color3.fromRGB(160, 150, 175)
		cardDesc.Font = Enum.Font.Gotham
		cardDesc.TextSize = 8
		cardDesc.TextXAlignment = Enum.TextXAlignment.Left
		cardDesc.Parent = card

		local applyBtn = Instance.new("TextButton")
		applyBtn.Size = UDim2.new(0, 48, 0, 18)
		applyBtn.Position = UDim2.new(1, -54, 0, 5)
		applyBtn.BackgroundColor3 = Color3.fromRGB(120, 60, 160)
		applyBtn.Text = "Apply"
		applyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		applyBtn.Font = Enum.Font.GothamBold
		applyBtn.TextSize = 8
		applyBtn.Parent = card
		Instance.new("UICorner", applyBtn).CornerRadius = UDim.new(0, 4)

		applyBtn.MouseButton1Click:Connect(function()
			applyPreset(presetTable)
			applyBtn.Text = "Done!"
			applyBtn.BackgroundColor3 = Color3.fromRGB(60, 140, 80)
			task.delay(1, function()
				if applyBtn and applyBtn.Parent then
					applyBtn.Text = "Apply"
					applyBtn.BackgroundColor3 = Color3.fromRGB(120, 60, 160)
				end
			end)
		end)
	end

	addPresetCard("Balanced", "Default balanced physical & visual values", DEFAULT_SETTINGS)
	addPresetCard("Huge", "Maximum size with increased weight", HUGE_PRESET)
	addPresetCard("Inflated", "Maximum size filled with air and extra bounce", INFLATED_PRESET)
	addPresetCard("Intensive", "Same as Balanced, but more intensive physics", INTENSIVE_PRESET)
end

createSettingsGui()

-- ==========================================
-- 11. MAIN LOOP: VISUALS + HIDE ORIGINAL + PHYSICS
-- ==========================================
RunService.PreSimulation:Connect(function(dt)
	if not scriptActive then return end

	-- ==========================================
	-- CYCLIC COLLISION CLEANUP (EVERY FRAME)
	-- ==========================================
	for _, data in pairs(activePlayers) do
		-- Очистка кастомных частей тела (Body/Butt)
		if data.customBodyParts then
			for _, part in ipairs(data.customBodyParts) do
				if part and part.Parent then
					part.CanCollide = false
					part.CanQuery = false
					part.CanTouch = false
					
					for _, desc in ipairs(part:GetDescendants()) do
						if desc:IsA("BasePart") then
							desc.CanCollide = false
							desc.CanQuery = false
							desc.CanTouch = false
						end
					end
				end
			end
		end
		
		-- Очистка модели бюста (Cloth/Bust)
		if data.cloth and data.cloth.Parent then
			data.cloth.CanCollide = false
			data.cloth.CanQuery = false
			data.cloth.CanTouch = false
			
			for _, desc in ipairs(data.cloth:GetDescendants()) do
				if desc:IsA("BasePart") then
					desc.CanCollide = false
					desc.CanQuery = false
					desc.CanTouch = false
				end
			end
		end
	end
	-- ==========================================

	local function setClothLocalTransparency(cloth, value)
		if not cloth or not cloth.Parent then return end
		if cloth:IsA("BasePart") then cloth.LocalTransparencyModifier = value end
		for _, desc in ipairs(cloth:GetDescendants()) do
			if desc:IsA("BasePart") then desc.LocalTransparencyModifier = value end
		end
	end

	-- A, B, C: VISIBILITY AND SCALING
	for player, data in pairs(activePlayers) do
		local isOtherPlayer = (player ~= LocalPlayer)
		local hideCustom = (Settings.LOCAL_PLAYER_ONLY and isOtherPlayer)

		-- 1. Bust Motor Offset & Scaling
		if data.bustMotor and data.bustMotor.Parent then
			data.bustMotor.C1 = CFrame.new(Settings.MOTOR_OFFSET_X, Settings.MOTOR_OFFSET_Y, Settings.MOTOR_OFFSET_Z)
		end
		
		if data.cloth and data.cloth.Parent then
			local hideBust = hideCustom or Settings.HIDE_ALL_BUSTS
			
			if hideBust then
				if data.cloth:IsA("BasePart") then data.cloth.Transparency = 1 end
				for _, desc in ipairs(data.cloth:GetDescendants()) do
					if desc:IsA("BasePart") then
						desc.Transparency = 1
					elseif desc:IsA("Decal") or desc:IsA("Texture") then
						if desc.Transparency < 1 then
							desc:SetAttribute("Changed", true)
							desc.Transparency = 1
						end
					end
				end
				setClothLocalTransparency(data.cloth, 1)
			else
				-- Восстановление бюста при выключении
				if data.cloth:IsA("BasePart") then data.cloth.Transparency = 0.02 end
				for _, desc in ipairs(data.cloth:GetDescendants()) do
					if desc:IsA("BasePart") then
						desc.Transparency = 0
					elseif desc:IsA("Decal") or desc:IsA("Texture") then
						if desc:GetAttribute("Changed") == true then
							desc.Transparency = 0
							desc:SetAttribute("Changed", nil)
						end
					end
				end
				
				if isOtherPlayer then
					setClothLocalTransparency(data.cloth, 0)
				elseif Settings.FORCE_FIRST_PERSON_VISIBILITY then
					setClothLocalTransparency(data.cloth, 0)
				end
			end

			local alpha = math.clamp((Settings.MODEL_SCALE - 1.0) / 0.5, 0, 1)
			local defaultClothBase = Vector3.new(0.569, 0.569, 0.569)
			local targetClothBase = Vector3.new(0.55525, 0.562, 0.495)
			local dynamicClothBase = defaultClothBase:Lerp(targetClothBase, alpha)
			for _, desc in ipairs(data.cloth:GetDescendants()) do
				if desc:IsA("SpecialMesh") then
					local baseScale = desc:GetAttribute("BaseScale")
					if not baseScale then
						baseScale = desc.Scale
						desc:SetAttribute("BaseScale", baseScale)
					end
					if desc.Parent == data.cloth then
						desc.Scale = dynamicClothBase * Settings.MODEL_SCALE
					else
						desc.Scale = baseScale * Settings.MODEL_SCALE
					end
				end
			end
		end

		-- 2. Original Body Parts Transparency (Возвращаем полностью 0 при hideCustom)
		local origParts = { data.origTorso, data.origLeftLeg, data.origRightLeg }
		local origTrans = hideCustom and 0 or 1
		for _, origPart in ipairs(origParts) do
			if origPart and origPart.Parent then
				if origPart.Transparency ~= origTrans then
					origPart.Transparency = origTrans
				end
				for _, ch in ipairs(origPart:GetChildren()) do
					if ch:IsA("Decal") and ch.Transparency ~= origTrans then
						ch.Transparency = origTrans
					end
				end
			end
		end

		-- 3. Custom Body Parts, Legs, Butt & Decals Transparency
		if data.customBodyParts then
			for _, customPart in ipairs(data.customBodyParts) do
				if customPart and customPart.Parent then
					if hideCustom then
						-- Скрытие для других игроков
						if customPart:IsA("BasePart") then
							customPart.Transparency = 1
						end
						for _, desc in ipairs(customPart:GetDescendants()) do
							if desc:IsA("BasePart") then
								desc.Transparency = 1
							elseif desc:IsA("Decal") or desc:IsA("Texture") then
								if desc.Transparency < 1 then
									desc:SetAttribute("Changed", true)
									desc.Transparency = 1
								end
							end
						end
					else
						-- Восстановление при выключении режима
						if customPart:IsA("BasePart") then
							customPart.Transparency = 0
						end
						for _, desc in ipairs(customPart:GetDescendants()) do
							if desc:IsA("BasePart") then
								desc.Transparency = 0
							elseif desc:IsA("Decal") or desc:IsA("Texture") then
								if desc:GetAttribute("Changed") == true then
									desc.Transparency = 0
									desc:SetAttribute("Changed", nil)
								end
							end
						end
					end
				end
			end
		end
	end

	if dt <= 0 then return end

	-- D. Physics (без изменений)
	for player, data in pairs(activePlayers) do
		local torso = data.torso
		if not torso or not torso.Parent then
			activePlayers[player] = nil
			continue
		end

		local hideCustom = (Settings.LOCAL_PLAYER_ONLY and player ~= LocalPlayer)
		local shouldUpdate = not hideCustom and ((player == LocalPlayer) or (player.Character and isVisible(player.Character, torso.Position)))
		
		if not shouldUpdate then
			data.bustPrevCF = nil
			data.buttPrevCF = nil
			if hideCustom then
				if data.bustMotor and data.bustMotor.Parent then data.bustMotor.Transform = CFrame.identity end
			end
			continue
		end

		local currentCF = torso.CFrame

		-- D.1. BUST PHYSICS
		if data.bustMotor and data.bustMotor.Parent and not Settings.HIDE_ALL_BUSTS then
			if not data.bustPrevCF then
				data.bustPrevCF = currentCF
				data.bustPrevVel = Vector3.zero
			else
				local worldLinVel = (currentCF.Position - data.bustPrevCF.Position) / dt
				local localLinVel = currentCF:VectorToObjectSpace(worldLinVel)
				local localAccel = (localLinVel - data.bustPrevVel) / dt
				data.bustPrevVel = localLinVel

				local deltaCF = data.bustPrevCF:ToObjectSpace(currentCF)
				local rx, ry, rz = deltaCF:ToOrientation()
				local localAngVel = Vector3.new(rx, ry, rz) / dt
				data.bustPrevCF = currentCF

				local totalForcePitch = localAngVel.X * Settings.INERTIA_SCALE_ROT
    			- (localAccel.Y * Settings.INERTIA_SCALE_LIN)
    			+ Settings.CLOTH_WEIGHT
				local totalForceYaw = -localAngVel.Y * Settings.INERTIA_SCALE_ROT + localAccel.X * Settings.INERTIA_SCALE_LIN
				local totalForceRoll = -localAngVel.Z * Settings.INERTIA_SCALE_ROT

				local devPitch = updateSpring(data.sPitch, totalForcePitch, dt, Settings.STIFFNESS, Settings.DAMPING, Settings.MAX_DEVIATION, Settings.SOFTNESS)
				local devYaw   = updateSpring(data.sYaw,   totalForceYaw,   dt, Settings.STIFFNESS, Settings.DAMPING, Settings.MAX_DEVIATION, Settings.SOFTNESS)
				local devRoll  = updateSpring(data.sRoll,  totalForceRoll,  dt, Settings.STIFFNESS, Settings.DAMPING, Settings.MAX_DEVIATION, Settings.SOFTNESS)

				data.bustMotor.Transform = CFrame.Angles(-devRoll, devYaw, -devPitch)
			end
		elseif Settings.HIDE_ALL_BUSTS then
			data.bustPrevCF = nil
			if data.bustMotor and data.bustMotor.Parent then data.bustMotor.Transform = CFrame.identity end
		end

		-- D.2. BUTT PHYSICS
		if Settings.BUTT_PHYSICS_ENABLED and data.buttMotor and data.buttMotor.Parent then
			if not data.buttPrevCF then
				data.buttPrevCF = currentCF
				data.buttPrevVel = Vector3.zero
			else
				local worldLinVel = (currentCF.Position - data.buttPrevCF.Position) / dt
				local localLinVel = currentCF:VectorToObjectSpace(worldLinVel)
				local localAccel = (localLinVel - data.buttPrevVel) / dt
				data.buttPrevVel = localLinVel

				local deltaCF = data.buttPrevCF:ToObjectSpace(currentCF)
				local rx, ry, rz = deltaCF:ToOrientation()
				local localAngVel = Vector3.new(rx, ry, rz) / dt
				data.buttPrevCF = currentCF

				local forcePitch = localAngVel.X * Settings.BUTT_INERTIA_ROT
				local forceYaw   = -localAngVel.Y * Settings.BUTT_INERTIA_ROT - localAccel.X * Settings.BUTT_INERTIA_LIN
				local forceRoll  = -localAngVel.Z * Settings.BUTT_INERTIA_ROT
				local forceY_Z   = localAccel.Y * Settings.BUTT_INERTIA_Y_Z

				local devPitch = updateSpring(data.bPitch, forcePitch, dt, Settings.BUTT_STIFFNESS, Settings.BUTT_DAMPING, Settings.BUTT_MAX_DEV, Settings.BUTT_SOFTNESS)
				local devYaw   = updateSpring(data.bYaw,   forceYaw,   dt, Settings.BUTT_STIFFNESS, Settings.BUTT_DAMPING, Settings.BUTT_MAX_DEV, Settings.BUTT_SOFTNESS)
				local devRoll  = updateSpring(data.bRoll,  forceRoll,  dt, Settings.BUTT_STIFFNESS, Settings.BUTT_DAMPING, Settings.BUTT_MAX_DEV, Settings.BUTT_SOFTNESS)
				local devZ     = updateSpring(data.bYZ,    forceY_Z,   dt, Settings.BUTT_STIFFNESS, Settings.BUTT_DAMPING, Settings.BUTT_MAX_DEV, Settings.BUTT_SOFTNESS)

				local buttBaseRot = CFrame.Angles(0, math.rad(90), math.rad(-5))
				local desiredButtRot = CFrame.Angles(0, devYaw, 0) * CFrame.Angles(devPitch + devZ, 0, 0) * CFrame.Angles(0, 0, devRoll)
				data.buttMotor.Transform = buttBaseRot:Inverse() * desiredButtRot * buttBaseRot
			end
		else
			data.buttPrevCF = nil
			if data.buttMotor and data.buttMotor.Parent then data.buttMotor.Transform = CFrame.identity end
		end
	end
end)

-- ==========================================
-- 11.1. FIRST-PERSON VISIBILITY OVERRIDE
-- ==========================================
RunService:BindToRenderStep("BustPhysicsFirstPersonVisibility", Enum.RenderPriority.Camera.Value + 1, function()
	if not scriptActive then return end

	-- 1. Body Override Fix (Opt-in via FORCE_BODY_FIRST_PERSON)
	if Settings.FORCE_BODY_FIRST_PERSON then
		local localData = activePlayers[LocalPlayer]
		if localData and localData.customBodyParts then
			for _, customPart in ipairs(localData.customBodyParts) do
				if customPart and customPart.Parent then
					if customPart:IsA("BasePart") then
						customPart.LocalTransparencyModifier = 0
					end
					for _, desc in ipairs(customPart:GetDescendants()) do
						if desc:IsA("BasePart") then
							desc.LocalTransparencyModifier = 0
						elseif desc:IsA("Decal") or desc:IsA("Texture") then
							-- Принудительно сбрасываем локальный модификатор и обычную прозрачность декалей
							desc.LocalTransparencyModifier = 0
							local baseTrans = desc:GetAttribute("BaseTrans") or 0
							desc.Transparency = baseTrans
						end
					end
				end
			end
		end
	end

	-- 2. Bust Override (via FORCE_FIRST_PERSON_VISIBILITY)
	if Settings.HIDE_ALL_BUSTS or not Settings.FORCE_FIRST_PERSON_VISIBILITY then return end

	local character = LocalPlayer.Character
	if not character then return end
	local cloth = character:FindFirstChild("Cloth", true)
	if not cloth then return end

	if cloth:IsA("BasePart") then
		cloth.LocalTransparencyModifier = 0
	end
	for _, desc in ipairs(cloth:GetDescendants()) do
		if desc:IsA("BasePart") then
			desc.LocalTransparencyModifier = 0
		elseif desc:IsA("Decal") or desc:IsA("Texture") then
			desc.LocalTransparencyModifier = 0
		end
	end
end)

-- ==========================================
-- 12. PLAYER MONITORING
-- ==========================================
local function monitorPlayer(player)
	player.CharacterAdded:Connect(function(char)
		task.spawn(function() setupUltimateCharacter(char, player) end)
	end)
	if player.Character then
		task.spawn(function() setupUltimateCharacter(player.Character, player) end)
	end
end

for _, player in ipairs(Players:GetPlayers()) do monitorPlayer(player) end
Players.PlayerAdded:Connect(monitorPlayer)
Players.PlayerRemoving:Connect(function(player) activePlayers[player] = nil end)

print("[Bust Physics ".. version .."] Loaded")