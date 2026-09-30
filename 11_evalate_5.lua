_DEBUG = true;
local v0 = {
    PRO = "Pro", 
    TRIAL = "Trial", 
    BASE = "Base", 
    RECODE = "recode"
};
local l_RECODE_0 = v0.RECODE;
local v2 = "2";
local v3 = "https://api.evalate.com/v2";
local v4 = "wss://api.evalate.com/v2";
local v5 = "0615683616";
local v6 = {
    ["content-type"] = "application/json"
};
local v9 = {
    time = 0, 
    start = function(v7)
        v7.time = common.get_timestamp();
    end, 
    stop = function(v8)
        return common.get_timestamp() - v8.time;
    end
};
v9:start();
local l_pui_0 = require("neverlose/pui");
local l_base64_0 = require("neverlose/base64");
local l_hashing_0 = require("neverlose/hashing");
local l_gradient_0 = require("neverlose/gradient");
local l_clipboard_0 = require("neverlose/clipboard");
local l_websockets_0 = require("neverlose/websockets");
l_pui_0.colors.red = color(255, 125, 125);
l_pui_0.colors.grey = color(141, 141, 141);
l_pui_0.colors.green = color(169, 182, 81);
local v16 = nil;
local v17 = nil;
do
    local l_v17_0 = v17;
    l_v17_0 = function(v19)
        -- upvalues: l_v17_0 (ref)
        local v20 = {};
        for v21, _ in pairs(v19) do
            table.insert(v20, v21);
        end;
        table.sort(v20);
        local v23 = "";
        for _, v25 in ipairs(v20) do
            local v26 = v19[v25];
            if type(v26) == "table" then
                v23 = v23 .. v25 .. l_v17_0(v26);
            else
                v23 = v23 .. v25 .. tostring(v26);
            end;
        end;
        return v23;
    end;
    v16 = function(v27, v28)
        -- upvalues: l_hashing_0 (ref), l_v17_0 (ref)
        return l_hashing_0.sha256(l_v17_0(v27) .. v28);
    end;
end;
v17 = function(v29, v30, v31)
    return v29 + (v30 - v29) * v31;
end;
local function v35(v32, v33, v34)
    if v32 < v33 then
        return v33;
    elseif v34 < v32 then
        return v34;
    else
        return v32;
    end;
end;
local function v39(v36, v37, v38)
    -- upvalues: v35 (ref)
    return vector(v35(v36.x, v37.x, v38.x), v35(v36.y, v37.y, v38.y), v35(v36.z, v37.z, v38.z));
end;
local function v46(v40, v41, v42)
    local v43 = {};
    for _, v45 in ipairs(v40) do
        if v45 == v41 then
            table.insert(v43, v42);
        else
            table.insert(v43, v45);
        end;
    end;
    return v43;
end;
local l_OpenExternalBrowserURL_0 = panorama.SteamOverlayAPI.OpenExternalBrowserURL;
local v48 = common.get_username();
local v49 = render.screen_size();
local v50 = {};
local v51 = {};
local v52 = {};
local v53 = {};
do
    local l_v52_0, l_v53_0 = v52, v53;
    v51.find = function(v56)
        -- upvalues: l_v53_0 (ref)
        return l_v53_0[v56];
    end;
    v51.get_storage = function()
        -- upvalues: l_v53_0 (ref)
        return l_v53_0;
    end;
    v51.new = function(v57, v58, ...)
        -- upvalues: l_v53_0 (ref)
        assert(l_v53_0[v57] == nil, string.format("menu.new - element with same name already exist (%s)", v57));
        if ... then
            v58:depend(...);
        end;
        l_v53_0[v57] = v58;
    end;
    v51.set_callback_list = function(v59, v60)
        -- upvalues: l_v52_0 (ref), l_pui_0 (ref), v46 (ref)
        local v61 = v59:id();
        l_v52_0[v61] = {
            v59:list()
        };
        local function v65()
            -- upvalues: v59 (ref), l_v52_0 (ref), v61 (ref), l_pui_0 (ref), v60 (ref), v46 (ref)
            local v62 = v59:get();
            local v63 = l_v52_0[v61][1];
            if not v63[v62] then
                return;
            else
                local v64 = l_pui_0.string(v60 and string.format("\v\226\128\162  \r%s", v63[v62]) or string.format("\v%s\r %s", v63[v62]:sub(1, 3), v63[v62]:sub(5)));
                v59:update(v46(v63, v63[v62], v64));
                return;
            end;
        end;
        l_v52_0[v61][2] = v65;
        v59:set_callback(v65, true);
    end;
end;
v52 = {
    movement = l_pui_0.find("Aimbot", "Anti Aim", "Misc", "Leg Movement"), 
    auto_stop = l_pui_0.find("Aimbot", "Ragebot", "Accuracy", "SSG-08", "Auto Stop", {
        double_tab = "Double Tap", 
        options = "Options"
    }), 
    freestanding = l_pui_0.find("Aimbot", "Anti Aim", "Angles", "Freestanding", {
        yaw = "Disable Yaw Modifiers", 
        body = "Body Freestanding"
    }), 
    double_tap = l_pui_0.find("Aimbot", "Ragebot", "Main", "Double Tap", {
        quick_switch = "Quick-Switch", 
        options = "Lag Options", 
        lag_limit = "Fake Lag Limit"
    }), 
    hide_shots = l_pui_0.find("Aimbot", "Ragebot", "Main", "Hide Shots", {
        options = "Options"
    }), 
    weapon_actions = l_pui_0.find("Miscellaneous", "Main", "Other", "Weapon Actions"), 
    air_strafe = l_pui_0.find("Miscellaneous", "Main", "Movement", "Air Strafe"), 
    strafe_assist = l_pui_0.find("Miscellaneous", "Main", "Movement", "Strafe Assist"), 
    body_aim = l_pui_0.find("Aimbot", "Ragebot", "Safety", "Body Aim"), 
    safe_points = l_pui_0.find("Aimbot", "Ragebot", "Safety", "Safe Points"), 
    peek_assist = l_pui_0.find("Aimbot", "Ragebot", "Main", "Peek Assist", {
        retreat_mode = "Retreat Mode"
    }), 
    scope_overlay = l_pui_0.find("Visuals", "World", "Main", "Override Zoom", "Scope Overlay"), 
    hitchance = l_pui_0.find("Aimbot", "Ragebot", "Selection", "Hit Chance"), 
    damage = l_pui_0.find("Aimbot", "Ragebot", "Selection", "Min. Damage"), 
    slow_walk = l_pui_0.find("Aimbot", "Anti Aim", "Misc", "Slow Walk"), 
    fake_duck = l_pui_0.find("Aimbot", "Anti Aim", "Misc", "Fake Duck"), 
    fake_lag = l_pui_0.find("Aimbot", "Anti Aim", "Fake Lag", "Enabled"), 
    unlock_cvars = l_pui_0.find("Miscellaneous", "Main", "Other", "Unlock Hidden Cvars"), 
    avoid_backstab = l_pui_0.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Avoid Backstab"), 
    is_min_damage = function(v66)
        for _, v68 in ipairs(ui.get_binds()) do
            if v68.reference:id() == v66.damage:id() and v68.active then
                return true;
            end;
        end;
        return false;
    end, 
    antiaim = {}
};
v52.antiaim.enabled = l_pui_0.find("Aimbot", "Anti Aim", "Angles", "Enabled");
v52.antiaim.yaw = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw");
v52.antiaim.pitch = ui.find("Aimbot", "Anti Aim", "Angles", "Pitch");
v52.antiaim.base = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Base");
v52.antiaim.hidden = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Hidden");
v52.antiaim.offset = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset");
v52.antiaim.modifier = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier");
v52.antiaim.modifier_degree = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset");
v52.antiaim.desync = ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw");
v52.antiaim.options = ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options");
v52.antiaim.inverter = ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter");
v52.antiaim.left_limit = ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit");
v52.antiaim.right_limit = ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit");
v52.antiaim.freestanding = ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Freestanding");
v53 = {
    home = l_pui_0.create("\v\f<house-blank>", {
        [1] = {
            [1] = "main", 
            [2] = "## main", 
            [3] = 1
        }, 
        [2] = {
            [1] = "lyrics", 
            [2] = "## lyrics", 
            [3] = 2
        }, 
        [3] = {
            [1] = "about", 
            [2] = "## about", 
            [3] = 2
        }, 
        [4] = {
            [1] = "leaderboard", 
            [2] = "## leaderboard", 
            [3] = 2
        }, 
        [5] = {
            [1] = "discord", 
            [2] = "## discord", 
            [3] = 2
        }, 
        [6] = {
            [1] = "stats_one", 
            [2] = "## stats_one", 
            [3] = 1
        }, 
        [7] = {
            [1] = "stats_two", 
            [2] = "## stats_two", 
            [3] = 1
        }, 
        [8] = {
            [1] = "stats_three", 
            [2] = "## stats_three", 
            [3] = 1
        }, 
        [9] = {
            [1] = "presets_setup", 
            [2] = "## presets setup", 
            [3] = 1
        }, 
        [10] = {
            [1] = "preset_information", 
            [2] = "## preset information ", 
            [3] = 1
        }, 
        [11] = {
            [1] = "preset_creation", 
            [2] = "## preset creation", 
            [3] = 2
        }, 
        [12] = {
            [1] = "preset_actions", 
            [2] = "## preset actions", 
            [3] = 2
        }, 
        [13] = {
            [1] = "local_presets", 
            [2] = "## local presets", 
            [3] = 2
        }, 
        [14] = {
            [1] = "cloud_presets", 
            [2] = "## cloud presets", 
            [3] = 2
        }
    }), 
    features = l_pui_0.create("\v\f<wave-sine>", {
        [1] = {
            [1] = "main", 
            [2] = "## main", 
            [3] = 1
        }, 
        [2] = {
            [1] = "settings", 
            [2] = "## settings", 
            [3] = 1
        }, 
        [3] = {
            [1] = "predict", 
            [2] = "## predict", 
            [3] = 2
        }, 
        [4] = {
            [1] = "air", 
            [2] = "## air", 
            [3] = 2
        }, 
        [5] = {
            [1] = "premium", 
            [2] = "## premium", 
            [3] = 2
        }, 
        [6] = {
            [1] = "widgets", 
            [2] = "## widgets", 
            [3] = 2
        }, 
        [7] = {
            [1] = "stack", 
            [2] = "## stack", 
            [3] = 2
        }, 
        [8] = {
            [1] = "crosshair", 
            [2] = "## crosshair", 
            [3] = 2
        }, 
        [9] = {
            [1] = "world", 
            [2] = "## world", 
            [3] = 1
        }, 
        [10] = {
            [1] = "breakers", 
            [2] = "## breakers", 
            [3] = 1
        }, 
        [11] = {
            [1] = "movement", 
            [2] = "## movement", 
            [3] = 2
        }, 
        [12] = {
            [1] = "game_focus", 
            [2] = "## game focus", 
            [3] = 1
        }, 
        [13] = {
            [1] = "grenade_features", 
            [2] = "## grenade features", 
            [3] = 2
        }, 
        [14] = {
            [1] = "scoreboard", 
            [2] = "## scoreboard", 
            [3] = 2
        }, 
        [15] = {
            [1] = "unlocks", 
            [2] = "## unlocks", 
            [3] = 1
        }
    }), 
    antiaim = l_pui_0.create("\v\f<shield>", {
        [1] = {
            [1] = "main", 
            [2] = "## main", 
            [3] = 1
        }, 
        [2] = {
            [1] = "enable", 
            [2] = "## enable", 
            [3] = 2
        }, 
        [3] = {
            [1] = "setup", 
            [2] = "## setup", 
            [3] = 2
        }, 
        [4] = {
            [1] = "setup_two", 
            [2] = "## setup two", 
            [3] = 2
        }, 
        [5] = {
            [1] = "binds", 
            [2] = "## binds", 
            [3] = 1
        }, 
        [6] = {
            [1] = "state", 
            [2] = "## state", 
            [3] = 1
        }, 
        [7] = {
            [1] = "defensive_state", 
            [2] = "## defensive state", 
            [3] = 1
        }, 
        [8] = {
            [1] = "message", 
            [2] = "## message", 
            [3] = 2
        }
    })
};
local v69 = {
    __home_list = {
        [1] = "\f<inbox>    Overview", 
        [2] = "\f<file>     Presets"
    }
};
v69.home = v53.home.main:list("", v69.__home_list, nil, false);
v69.__features_list = {
    [1] = "\f<wave-sine>   Aimbot", 
    [2] = "\f<paintbrush>    Visual", 
    [3] = "\f<bars-sort>     Misc"
};
v69.features = v53.features.main:list("", v69.__features_list, nil, false);
v69.__antiaim_list = {
    [1] = "\f<clone>    Setup", 
    [2] = "\f<code-branch>     Builder", 
    [3] = "\f<solar-system>    Defensive"
};
v69.antiaim = v53.antiaim.main:list("", v69.__antiaim_list, nil, false);
v51.set_callback_list(v69.home);
v51.set_callback_list(v69.antiaim);
v51.set_callback_list(v69.features);
local v70 = {
    home = {}
};
v70.home.overview = {
    [1] = nil, 
    [2] = 1, 
    [1] = v69.home
};
v70.home.presets = {
    [1] = nil, 
    [2] = 2, 
    [1] = v69.home
};
v70.home.not_presets = {
    [1] = nil, 
    [2] = 2, 
    [3] = true, 
    [1] = v69.home
};
v70.features = {};
v70.features.aimbot = {
    [1] = nil, 
    [2] = 1, 
    [1] = v69.features
};
v70.features.visual = {
    [1] = nil, 
    [2] = 2, 
    [1] = v69.features
};
v70.features.misc = {
    [1] = nil, 
    [2] = 3, 
    [1] = v69.features
};
v70.antiaim = {};
v70.antiaim.setup = {
    [1] = nil, 
    [2] = 1, 
    [1] = v69.antiaim
};
v70.antiaim.builder = {
    [1] = nil, 
    [2] = 2, 
    [1] = v69.antiaim
};
v70.antiaim.defensive = {
    [1] = nil, 
    [2] = 3, 
    [1] = v69.antiaim
};
local v71 = nil;
local v72 = nil;
local v73 = {};
do
    local l_v73_0 = v73;
    v71 = function(v75, v76)
        -- upvalues: l_v73_0 (ref)
        if l_v73_0[v75] == nil then
            l_v73_0[v75] = {};
        end;
        if l_v73_0[v75][v76] == true then
            return;
        else
            events[v75]:set(v76);
            l_v73_0[v75][v76] = true;
            return;
        end;
    end;
    v72 = function(v77, v78)
        -- upvalues: l_v73_0 (ref)
        if l_v73_0[v77] and l_v73_0[v77][v78] == true then
            l_v73_0[v77][v78] = nil;
        end;
        events[v77]:unset(v78);
    end;
end;
v73 = nil;
local v79 = {};
do
    local l_v79_0 = v79;
    local function v83(...)
        -- upvalues: l_v79_0 (ref)
        for v81, v82 in pairs(l_v79_0) do
            if v82 then
                v81(...);
            end;
        end;
    end;
    events.close_shot = function(v84, v85)
        -- upvalues: l_v79_0 (ref)
        if v85 then
            l_v79_0[v84] = nil;
        else
            l_v79_0[v84] = true;
        end;
    end;
    local v86 = 0;
    local function v91(v87)
        -- upvalues: v86 (ref)
        local v88 = entity.get_local_player();
        local v89 = entity.get(v87.userid, true);
        local v90 = entity.get(v87.attacker, true);
        if v88 == v89 and v88 ~= v90 then
            v86 = globals.tickcount;
        end;
    end;
    local v92 = nil;
    local function v101(v93)
        -- upvalues: v92 (ref), v86 (ref), v83 (ref)
        local l_tickcount_0 = globals.tickcount;
        if v92 == l_tickcount_0 then
            return;
        else
            local v95 = entity.get_local_player();
            local v96 = entity.get(v93.userid, true);
            if not v95 or not v95:is_alive() or not v96 or v96:is_dormant() or not v96:is_enemy() then
                return;
            else
                local v97 = v95:get_eye_position();
                local v98 = v96:get_eye_position();
                if not v97 or not v98 then
                    return;
                else
                    local v99 = vector(v93.x, v93.y, v93.z);
                    local v100 = v97:closest_ray_point(v98, v99):dist(v97);
                    if v100 < 60 then
                        utils.execute_after(to_time(1), function()
                            -- upvalues: l_tickcount_0 (ref), v86 (ref), v83 (ref), v100 (ref), v96 (ref), v99 (ref)
                            if l_tickcount_0 - v86 ~= 0 then
                                v83({
                                    distance = v100, 
                                    entity = v96, 
                                    impact = v99
                                });
                            end;
                        end);
                        v92 = globals.tickcount;
                    end;
                    return;
                end;
            end;
        end;
    end;
    events.player_hurt(v91);
    events.bullet_impact(v101);
end;
v79 = nil;
local function v103(v102)
    -- upvalues: l_hashing_0 (ref)
    return l_hashing_0.sha256(string.format("%sua", v102));
end;
local _ = nil;
local v105 = v53.home.about:switch("\208\191\208\190\208\187\208\190\209\130\208\181\208\189\209\135\208\181\208\179");
v105:visibility(false);
do
    local l_v105_0 = v105;
    local function v107()
        -- upvalues: l_v105_0 (ref)
        l_v105_0:set(not l_v105_0:get());
    end;
    v53.home.about:label("\v\fLuch    \rWhat's up"):depend(v70.home.overview);
    v53.home.about:button(v48, nil, true):depend(v70.home.overview);
    v53.home.about:label("\v\f<code>    \rVersion"):depend(v70.home.overview);
    v53.home.about:button(l_RECODE_0, nil, true):depend(v70.home.overview);
    local v108 = false;
    do
        local l_v108_0 = v108;
        local function v110()
            -- upvalues: l_v108_0 (ref)
            return l_v108_0;
        end;
        local _ = v53.home.about:label(" \v\f<fire-flame-curved>     \rStreak"):depend(v70.home.overview, {
            [1] = l_v105_0, 
            [2] = v110
        });
        local v112 = v53.home.about:button("", nil, true):depend(v70.home.overview, {
            [1] = l_v105_0, 
            [2] = v110
        });
        v112:tooltip("\v\f<circle-info>   \rYour streak loves daily attention!");
        local function v116(v113)
            -- upvalues: v112 (ref), l_v108_0 (ref), v107 (ref)
            local l_status_0, l_result_0 = pcall(json.parse, v113);
            if not l_status_0 or not l_result_0 or not l_result_0.streak then
                return print("Streak request failed. Response: ", v113);
            else
                v112:name(("%sx"):format(l_result_0.streak));
                l_v108_0 = true;
                v107();
                return;
            end;
        end;
        local v117 = {
            cheat = "NL", 
            script = l_RECODE_0, 
            username = v48, 
            timestamp = common.get_timestamp()
        };
        v117.signature = v16(v117, v5);
        network.post(v3 .. "/streak/", v117, v6, v116);
    end;
    v108 = false;
    do
        local l_v108_1 = v108;
        local function v119()
            -- upvalues: l_v108_1 (ref)
            return l_v108_1;
        end;
        local _ = v53.home.about:label("\v\f<tower-broadcast>    \rOnline"):depend(v70.home.overview, {
            [1] = l_v105_0, 
            [2] = v119
        });
        local v121 = v53.home.about:button("", nil, true):depend(v70.home.overview, {
            [1] = l_v105_0, 
            [2] = v119
        });
        local v122 = nil;
        local v123 = nil;
        local v124 = 0;
        local v125 = false;
        local function v128()
            local v126 = utils.net_channel();
            if not v126 or v126.is_loopback then
                return;
            else
                local v127 = v126:get_server_info();
                if not v127 then
                    return;
                else
                    return v127.address;
                end;
            end;
        end;
        local function v129()
            -- upvalues: v123 (ref), v128 (ref)
            utils.execute_after(1, function()
                -- upvalues: v123 (ref), v128 (ref)
                if not v123 then
                    return;
                else
                    v123:send(v128() or "");
                    return;
                end;
            end);
        end;
        local v141 = {
            open = function(v130)
                -- upvalues: v124 (ref), v123 (ref), v129 (ref)
                v124 = 0;
                v123 = v130;
                v129();
            end, 
            message = function(_, v132)
                -- upvalues: v121 (ref), l_v108_1 (ref), v107 (ref), v79 (ref)
                local l_status_1, l_result_1 = pcall(json.parse, v132);
                if l_status_1 then
                    v121:name(tostring(#l_result_1));
                    l_v108_1 = true;
                    v107();
                    v79 = l_result_1;
                else
                    v121:name("");
                    l_v108_1 = false;
                    v107();
                end;
            end, 
            error = function(_, _)
                -- upvalues: v123 (ref), v122 (ref)
                v123 = nil;
                v122();
            end, 
            close = function(_, _, _, _)
                -- upvalues: v123 (ref), v122 (ref)
                v123 = nil;
                v122();
            end
        };
        local function v148()
            -- upvalues: v124 (ref), v125 (ref), v103 (ref), v48 (ref), l_RECODE_0 (ref), v16 (ref), v5 (ref), l_websockets_0 (ref), v4 (ref), v141 (ref), v3 (ref), v6 (ref)
            if v124 > 2 then
                return print("unable to reconnect after 3 attempts");
            else
                v124 = v124 + 1;
                v125 = false;
                local v142 = v103(panorama.MyPersonaAPI.GetXuid());
                local v143 = {
                    cheat = "NL", 
                    secret = v142, 
                    username = v48, 
                    build_name = l_RECODE_0, 
                    timestamp = common.get_unixtime()
                };
                v143.signature = v16(v143, v5);
                local function v147(v144)
                    -- upvalues: l_websockets_0 (ref), v4 (ref), v141 (ref)
                    local l_status_2, l_result_2 = pcall(json.parse, v144);
                    if not l_status_2 or not l_result_2 or not l_result_2.key then
                        return print("Failed to register websocket key. Response: ", v144);
                    else
                        l_websockets_0.connect(v4 .. "/communication/" .. l_result_2.key, v141);
                        return;
                    end;
                end;
                network.post(v3 .. "/communication/register-key", v143, v6, v147);
                return;
            end;
        end;
        v122 = function()
            -- upvalues: v123 (ref), v125 (ref), v148 (ref)
            if v123 or v125 then
                return print("attempted futile reconnection stopped");
            else
                v125 = true;
                utils.execute_after(5, v148);
                return;
            end;
        end;
        v148();
        events.level_init(v129);
        events.round_start(v129);
        local v149 = false;
        events.render(function()
            -- upvalues: v149 (ref), v129 (ref)
            local l_is_in_game_0 = globals.is_in_game;
            if v149 ~= l_is_in_game_0 then
                if not l_is_in_game_0 then
                    v129();
                end;
                v149 = l_is_in_game_0;
            end;
        end);
    end;
    v108 = {
        [1] = "I wanna be your lover", 
        [2] = "Too sexy for this world", 
        [3] = "I love to watch you dance", 
        [4] = "You were on top, I put you on top", 
        [5] = "Oh, I choose you to fill your void", 
        [6] = "But falling for you was my mistake", 
        [7] = "Give it up, give up that threesome", 
        [8] = "You're the one, you're the only one", 
        [9] = "Tell me lies, ooh, girl, tell me lies", 
        [10] = "I'm in love with both at the same time", 
        [11] = "Goddamn, you look good in this lighting", 
        [12] = "Say you're mine, I'm yours for the night", 
        [13] = "Ooh, she mine, ooh, girl, bump and grind", 
        [14] = "Call out my name when I kiss you so gently", 
        [15] = "Woke up by a girl, I don't even know her name", 
        [16] = "I said I didn't feel nothing, baby, but I lied", 
        [17] = "But if you call me up, I'm fuckin' you on sight", 
        [18] = "You try to fill the void with every man you meet", 
        [19] = "Your face is like a melody - It won't leave my head", 
        [20] = "That all the nights you slept alone, dryin' your eyes"
    };
    local v151 = v53.home.lyrics:label(""):depend(v70.home.overview);
    do
        local l_v108_2, l_v151_0 = v108, v151;
        local function v156(v154)
            -- upvalues: l_v108_2 (ref), l_v151_0 (ref)
            if v154.value == 1 then
                local v155 = l_v108_2[math.random(1, #l_v108_2)] or "";
                l_v151_0:name(v155);
            end;
        end;
        v69.home:set_callback(v156, true);
    end;
    v108 = math.huge;
    v151 = false;
    local v157 = false;
    do
        local l_v108_3, l_v151_1, l_v157_0 = v108, v151, v157;
        local v161 = {
            participate = v53.home.leaderboard:switch(" \v\f<play>     \rParticipate"):depend(v70.home.overview, {
                [1] = l_v105_0, 
                [2] = function()
                    -- upvalues: l_v157_0 (ref)
                    return l_v157_0;
                end
            })
        };
        v53.home.leaderboard:label("\v\f<circle-info>     \rWhat's that"):depend(v70.home.overview, v161.participate, {
            [1] = l_v105_0, 
            [2] = function()
                -- upvalues: l_v157_0 (ref)
                return l_v157_0;
            end
        });
        v53.home.leaderboard:button(" \v\f<arrow-up-right-from-square> ", function()
            -- upvalues: l_OpenExternalBrowserURL_0 (ref)
            l_OpenExternalBrowserURL_0("https://evalate.com/competition");
        end, true):depend(v70.home.overview, v161.participate, {
            [1] = l_v105_0, 
            [2] = function()
                -- upvalues: l_v157_0 (ref)
                return l_v157_0;
            end
        });
        v53.home.leaderboard:label("\v\f<trophy>    \rLeaderboard"):depend(v70.home.overview, v161.participate, {
            [1] = l_v105_0, 
            [2] = function()
                -- upvalues: l_v151_1 (ref), l_v157_0 (ref)
                return l_v151_1 and l_v157_0;
            end
        });
        v161.place = v53.home.leaderboard:button("", nil, true):depend(v70.home.overview, v161.participate, {
            [1] = l_v105_0, 
            [2] = function()
                -- upvalues: l_v151_1 (ref), l_v157_0 (ref)
                return l_v151_1 and l_v157_0;
            end
        });
        v161.points = v53.home.leaderboard:button("", nil, true):depend(v70.home.overview, v161.participate, {
            [1] = l_v105_0, 
            [2] = function()
                -- upvalues: l_v151_1 (ref), l_v157_0 (ref)
                return l_v151_1 and l_v157_0;
            end
        });
        local function v164(v162, v163)
            -- upvalues: v161 (ref), l_v151_1 (ref), v107 (ref)
            v161.place:name(v162);
            v161.points:name(v163);
            l_v151_1 = true;
            v107();
        end;
        local v165 = {
            username = v48, 
            timestamp = common.get_unixtime()
        };
        v165.signature = v16(v165, v5);
        local function v169(v166)
            -- upvalues: l_v157_0 (ref), v107 (ref), v164 (ref), l_v108_3 (ref)
            local l_status_3, l_result_3 = pcall(json.parse, v166);
            if not l_status_3 or not l_result_3 then
                return print("Failed to get leaderboard player. Response: ", v166);
            else
                if l_result_3.message == "Account not found." or l_result_3.username then
                    l_v157_0 = true;
                    v107();
                end;
                if l_result_3.username then
                    if l_result_3.banned then
                        v164("Banned", l_result_3.reason and l_result_3.reason or "?");
                    else
                        v164(string.format("%s place", l_result_3.place), string.format("%s points", l_result_3.points));
                        l_v108_3 = l_result_3.place;
                    end;
                end;
                return;
            end;
        end;
        network.post(v3 .. "/leaderboard/me", v165, v6, v169);
        v165 = 0;
        v169 = 0;
        local v170 = 0;
        local v171 = {};
        local v172 = {};
        do
            local l_v165_0, l_v169_0, l_v170_0, l_v171_0, l_v172_0 = v165, v169, v170, v171, v172;
            local function v178()
                -- upvalues: l_v165_0 (ref), l_v169_0 (ref), l_v170_0 (ref), l_v171_0 (ref), l_v172_0 (ref)
                l_v165_0 = 0;
                l_v169_0 = 0;
                l_v170_0 = 0;
                l_v171_0 = {};
                l_v172_0 = {};
            end;
            local _ = {};
            local function v184()
                local v180 = utils.net_channel();
                if not v180 or v180.is_loopback then
                    return;
                else
                    local v181 = string.lower(panorama.GameStateAPI.GetServerName());
                    local function v183(v182)
                        -- upvalues: v181 (ref)
                        return string.find(v181, v182) ~= nil;
                    end;
                    return v183("hvh") or v183("unmatched.gg");
                end;
            end;
            local function v186()
                local v185 = entity.get_game_rules();
                return v185 and v185.m_bWarmupPeriod;
            end;
            local function v187()
                return #entity.get_players(false, true);
            end;
            local function v188()
                -- upvalues: v184 (ref), v186 (ref), v187 (ref)
                return v184() and not v186() and v187() >= 8;
            end;
            local function v190()
                local v189 = entity.get_game_rules();
                if not v189 then
                    return;
                else
                    return v189.m_totalRoundsPlayed, math.floor(globals.curtime - v189.m_fRoundStartTime);
                end;
            end;
            local function v193(v191)
                -- upvalues: v188 (ref), l_v172_0 (ref), l_v169_0 (ref)
                local v192 = v191.entity:get_xuid();
                if not v191.entity:is_bot() and v188() and not l_v172_0[v192] then
                    l_v169_0 = l_v169_0 + 1;
                    l_v172_0[v192] = true;
                end;
            end;
            local function v196()
                local v194 = utils.net_channel();
                if not v194 or v194.is_loopback then
                    return;
                else
                    local v195 = v194:get_server_info();
                    if not v195 then
                        return;
                    else
                        return v195.address;
                    end;
                end;
            end;
            local function v202(v197)
                -- upvalues: v188 (ref), l_v171_0 (ref), l_v165_0 (ref), l_v170_0 (ref)
                local v198 = entity.get_local_player();
                local v199 = entity.get(v197.userid, true);
                local v200 = entity.get(v197.attacker, true);
                local v201 = v199:get_xuid();
                if v198 == v200 and v198 ~= v199 and not v199:is_bot() and v188() and not l_v171_0[v201] then
                    l_v165_0 = l_v165_0 + 1;
                    if v197.headshot then
                        l_v170_0 = l_v170_0 + 1;
                    end;
                    l_v171_0[v201] = true;
                end;
            end;
            local function v222()
                -- upvalues: l_v165_0 (ref), l_v170_0 (ref), l_v169_0 (ref), v196 (ref), v187 (ref), v190 (ref), l_RECODE_0 (ref), v48 (ref), v16 (ref), v5 (ref), v50 (ref), l_v108_3 (ref), v164 (ref), v3 (ref), v6 (ref), v178 (ref)
                if l_v165_0 + l_v170_0 + l_v169_0 < 1 then
                    return;
                else
                    local v203 = v196();
                    local v204 = v187();
                    local v205, v206 = v190();
                    local v207 = {
                        cheat = "NL", 
                        script = l_RECODE_0, 
                        kills = l_v165_0, 
                        misses = l_v169_0, 
                        headshots = l_v170_0, 
                        server_ip = v203, 
                        round = v205, 
                        round_time = v206, 
                        players_on_the_server = v204, 
                        username = v48, 
                        timestamp = common.get_unixtime()
                    };
                    v207.signature = v16(v207, v5);
                    local function v221(v208)
                        -- upvalues: v50 (ref), l_v108_3 (ref), v164 (ref)
                        local l_status_4, l_result_4 = pcall(json.parse, v208);
                        if not l_status_4 or not l_result_4 then
                            return print("Failed to send leaderboard data. Response: ", v208);
                        elseif not l_result_4.points_got then
                            return;
                        else
                            local v211 = v50.build("You got {points_got} points", nil, {
                                points_got = l_result_4.points_got
                            });
                            do
                                local l_v211_0 = v211;
                                local function v215(v213, v214)
                                    -- upvalues: v50 (ref), l_v211_0 (ref)
                                    return v50.center(v214, nil, v213.alpha, l_v211_0);
                                end;
                                v50.print(l_v211_0);
                                v50.screen(v215);
                            end;
                            v211 = nil;
                            if l_result_4.place > l_v108_3 then
                                v211 = "\226\150\188 You moved down to {place} place";
                            end;
                            if l_result_4.place < l_v108_3 then
                                v211 = "\226\150\178 You moved up to {place} place";
                            end;
                            if v211 then
                                local v216 = v50.build(v211, nil, {
                                    place = l_result_4.place
                                });
                                do
                                    local l_v216_0 = v216;
                                    local function v220(v218, v219)
                                        -- upvalues: v50 (ref), l_v216_0 (ref)
                                        return v50.center(v219, nil, v218.alpha, l_v216_0);
                                    end;
                                    v50.print(l_v216_0);
                                    v50.screen(v220);
                                end;
                            end;
                            v164(string.format("%s place", l_result_4.place), string.format("%s points", l_result_4.points));
                            l_v108_3 = l_result_4.place;
                            return;
                        end;
                    end;
                    network.post(v3 .. "/leaderboard/data", v207, v6, v221);
                    v178();
                    return;
                end;
            end;
            local function v224(v223)
                -- upvalues: v193 (ref), v222 (ref), v202 (ref)
                events.close_shot(v193, not v223.value);
                events.round_start(v222, v223.value);
                events.player_death(v202, v223.value);
            end;
            v161.participate:set_callback(v224, true);
        end;
    end;
end;
v105 = function()
    -- upvalues: l_OpenExternalBrowserURL_0 (ref)
    l_OpenExternalBrowserURL_0("https://neverlose.cc/market/item?id=I7FKHv");
end;
v53.home.discord:label("\v\f<trophy>    \r666 IMMORTAL FOR FREE"):depend(v70.home.overview);
v53.home.discord:button(" \v\f<arrow-up-right-from-square> ", v105, true):depend(v70.home.overview);
v53.home.discord:label("\v\f<discord>    \rCracked By luch"):depend(v70.home.overview);
v53.home.discord:button(" \v\f<arrow-up-right-from-square> ", nil, true):depend(v70.home.overview):set_callback(function()
    -- upvalues: l_OpenExternalBrowserURL_0 (ref)
    l_OpenExternalBrowserURL_0("https://discord.gg/VS4msFx6EE");
end);
v105 = v53.home.discord:label("\v\f<user-tag>    \rCyber Lox ebaniy"):depend(v70.home.overview);
local v225 = v53.home.discord:button(" \v\f<key> ", nil, true):depend(v70.home.overview);
local v226 = "\v\f<circle-info>   \rHow to get role on the server:\n\n1. Join discord server\n\n2. Get code using   \v\f<key>  \rbutton\n\n3. Paste your code in the \v#get-role \rchannel on the server";
v105:tooltip(v226);
v225:tooltip(v226);
local function v230(v227)
    -- upvalues: l_clipboard_0 (ref)
    local l_status_5, l_result_5 = pcall(json.parse, v227);
    if not l_status_5 or not l_result_5 or not l_result_5.code then
        return print("Failed to get verification code: Response: ", v227);
    else
        l_clipboard_0.set(l_result_5.code);
        common.add_notify("Discord", "Code was successfully copied");
        return;
    end;
end;
do
    local l_v230_0 = v230;
    v225:set_callback(function()
        -- upvalues: v48 (ref), l_RECODE_0 (ref), v16 (ref), v5 (ref), v3 (ref), v6 (ref), l_v230_0 (ref)
        local v232 = {
            cheat = "NL", 
            username = v48, 
            build_name = l_RECODE_0, 
            timestamp = common.get_unixtime()
        };
        v232.signature = v16(v232, v5);
        network.post(v3 .. "/discord-verification/get-code", v232, v6, l_v230_0);
    end);
end;
v105 = nil;
v225 = "evalate_activity";
v226 = db[v225] or {
    total_time = 0, 
    game = {
        headshots = 0, 
        total_kills = 0, 
        misses_at_you = 0
    }
};
v226.ragebot = v226.ragebot or {};
v226.ragebot.hit = v226.ragebot.hit or 0;
v226.ragebot.miss = v226.ragebot.miss or 0;
v230 = common.get_timestamp();
do
    local l_v225_0, l_v226_0, l_v230_1 = v225, v226, v230;
    local function v236()
        -- upvalues: l_v230_1 (ref)
        return common.get_timestamp() - l_v230_1;
    end;
    local function v241(v237)
        local v238 = math.floor(v237 / 1000);
        local v239 = math.floor(v238 / 60);
        local v240 = v239 / 60;
        if math.floor(v240) > 0 then
            return ("%.1fh"):format(v240);
        elseif v239 > 0 then
            return v239 .. "m";
        else
            return v238 .. "s";
        end;
    end;
    local v242 = {};
    local function v248(v243, v244, v245)
        -- upvalues: v70 (ref), v242 (ref)
        v243:label(v244):depend(v70.home.overview);
        local v246 = v245();
        local v247 = v243:button(string.format("%s", v246), nil, true):depend(v70.home.overview);
        table.insert(v242, {
            name = v244, 
            button = v247, 
            callback = v245, 
            old = v246
        });
    end;
    local function v251()
        -- upvalues: v242 (ref)
        if ui.get_alpha() > 0 then
            for _, v250 in next, v242 do
                if v250.old ~= v250.callback() then
                    v250.button:name(string.format("%s", v250.callback()));
                    v250.old = v250.callback();
                end;
            end;
        end;
    end;
    local function v255(v252)
        -- upvalues: l_v226_0 (ref)
        local v253 = entity.get_local_player();
        local v254 = entity.get(v252.userid, true);
        if entity.get(v252.attacker, true) == v253 and v254 ~= v253 and not v254:is_bot() then
            l_v226_0.game.total_kills = l_v226_0.game.total_kills + 1;
            if v252.headshot then
                l_v226_0.game.headshots = l_v226_0.game.headshots + 1;
            end;
        end;
    end;
    local function v257(v256)
        -- upvalues: l_v226_0 (ref)
        if not v256.entity:is_bot() then
            l_v226_0.game.misses_at_you = l_v226_0.game.misses_at_you + 1;
        end;
    end;
    local function v258()
        -- upvalues: l_v226_0 (ref), v236 (ref), l_v225_0 (ref)
        l_v226_0.total_time = l_v226_0.total_time + v236();
        db[l_v225_0] = l_v226_0;
    end;
    local function v260(v259)
        -- upvalues: l_v226_0 (ref)
        if not v259.target:is_bot() then
            if v259.state then
                l_v226_0.ragebot.miss = l_v226_0.ragebot.miss + 1;
            else
                l_v226_0.ragebot.hit = l_v226_0.ragebot.hit + 1;
            end;
        end;
    end;
    v248(v53.home.stats_one, "\v\f<clock>     \rTotal", function()
        -- upvalues: v241 (ref), l_v226_0 (ref), v236 (ref)
        return v241(l_v226_0.total_time + v236());
    end);
    v248(v53.home.stats_one, "\v\f<timer>     \rSession", function()
        -- upvalues: v241 (ref), v236 (ref)
        return v241(v236());
    end);
    v248(v53.home.stats_two, "\v\f<skull>     \rHeadshots", function()
        -- upvalues: l_v226_0 (ref)
        local v261 = l_v226_0.game.headshots / l_v226_0.game.total_kills;
        return string.format("%s%%", v261 > 0 and math.floor(100 * v261) or 0);
    end);
    v248(v53.home.stats_two, "\v\f<user-slash>    \rEnemy killed", function()
        -- upvalues: l_v226_0 (ref)
        return l_v226_0.game.total_kills;
    end);
    v248(v53.home.stats_two, "\v\f<user-xmark>    \rMisses at me", function()
        -- upvalues: l_v226_0 (ref)
        return l_v226_0.game.misses_at_you;
    end);
    v248(v53.home.stats_three, "\v\f<user-check>    \rHit rate", function()
        -- upvalues: l_v226_0 (ref)
        local v262 = l_v226_0.ragebot.hit / (l_v226_0.ragebot.hit + l_v226_0.ragebot.miss);
        local v263 = v262 > 0 and math.floor(100 * v262) or 0;
        return string.format("%s%%", v263);
    end);
    v248(v53.home.stats_three, "\v\f<check>      \rShots hit", function()
        -- upvalues: l_v226_0 (ref)
        return l_v226_0.ragebot.hit;
    end);
    v248(v53.home.stats_three, " \v\f<xmark>      \rShots missed", function()
        -- upvalues: l_v226_0 (ref)
        return l_v226_0.ragebot.miss;
    end);
    events.aim_ack(v260);
    events.render(v251);
    events.shutdown(v258);
    events.close_shot(v257);
    events.player_death(v255);
end;
v225 = {};
_menu = {};
_depend = {};
_menu.preset_information = {};
v226 = false;
_menu.storage = v53.home.presets_setup:combo("\v\f<database>    \rStorage", {
    [1] = "\v\f<cloud>   \rCloud", 
    [2] = "\v\f<desktop>    \rLocal"
}):depend(v70.home.presets);
_depend.storage = {
    cloud = {
        [1] = _menu.storage, 
        [2] = _menu.storage:list()[1]
    }, 
    ["local"] = {
        [1] = _menu.storage, 
        [2] = _menu.storage:list()[2]
    }
};
_menu.settings = v53.home.presets_setup:label("\v\f<gear>   \rSettings", nil, function(v264)
    return {
        sort = v264:combo("\v\f<bars-sort>    \rSort", {
            [1] = "\v\f<floppy-disk>    \rLast Update", 
            [2] = "\v\f<heart>   \rMost Liked", 
            [3] = " \v\f<play>   \rMost Loaded"
        }), 
        filter = v264:combo("\v\f<bars-filter>    \rFilter", {
            [1] = "\v\f<list>   \rNone", 
            [2] = "\v\f<user>   \rMy", 
            [3] = "\v\f<heart>   \rLiked"
        }), 
        show_info = v264:switch("\v\f<bars>    \rShow Information", true)
    };
end);
_menu.settings:depend(v70.home.presets);
_menu.settings.sort:depend(_depend.storage.cloud);
_menu.settings.filter:depend(_depend.storage.cloud);
v230 = {
    l_pui_0.string("\v\f<spinner>   \rLoading...")
};
local v265 = {
    l_pui_0.string("\v\f<face-frown-slight>    \rNo presets found")
};
_menu.local_actions = {};
_menu.local_actions.load = v53.home.local_presets:button("   \f<play>  ", nil, false, "Load"):depend(v70.home.presets, _depend.storage["local"]);
_menu.local_actions.load_antiaims = v53.home.local_presets:button("  \f<shield>  ", nil, false, "Load only anti-aim's"):depend(v70.home.presets, _depend.storage["local"]);
_menu.local_actions.copy = v53.home.local_presets:button("  \f<copy>  ", nil, true, "Copy to clipboard"):depend(v70.home.presets, _depend.storage["local"]);
_menu.local_actions.save = v53.home.local_presets:button("  \f<floppy-disk>  ", nil, true, "Save"):depend(v70.home.presets, _depend.storage["local"]);
_menu.local_actions.delete = v53.home.local_presets:button("  \a[red]\f<trash>  ", nil, true, "Delete"):depend(v70.home.presets, _depend.storage["local"]);
_menu.local_presets = v53.home.local_presets:list("", v230):depend(v70.home.presets, _depend.storage["local"]);
_menu.cloud_actions = {};
_menu.cloud_actions.load = v53.home.cloud_presets:button("   \f<play>  ", nil, false, "Load"):depend(v70.home.presets, _depend.storage.cloud);
_menu.cloud_actions.load_antiaims = v53.home.cloud_presets:button("  \f<shield>  ", nil, false, "Load only anti-aim's"):depend(v70.home.presets, _depend.storage.cloud);
_menu.cloud_actions.like = v53.home.cloud_presets:button("  \f<heart>  ", nil, true, "Like"):depend(v70.home.presets, _depend.storage.cloud);
_menu.cloud_actions.save = v53.home.cloud_presets:button("  \f<floppy-disk>  ", nil, true, "Save"):depend(v70.home.presets, _depend.storage.cloud);
_menu.cloud_actions.delete = v53.home.cloud_presets:button("  \a[red]\f<trash>  ", nil, true, "Delete"):depend(v70.home.presets, _depend.storage.cloud);
_menu.cloud_presets = v53.home.cloud_presets:list("", v230):depend(v70.home.presets, _depend.storage.cloud);
v53.home.preset_actions:label("\v\f<arrow-pointer>    \rActions"):depend(v70.home.presets, _depend.storage.cloud);
_menu.upload = v53.home.preset_actions:button(" \v\f<cloud-arrow-up>   \rUpload ", nil, true):depend(v70.home.presets, _depend.storage.cloud):disabled(l_RECODE_0 == v0.TRIAL);
_menu.actions_label = v53.home.preset_actions:label("\v\f<arrow-pointer>    \rActions "):depend(v70.home.presets, _depend.storage["local"]);
_menu.create = v53.home.preset_actions:button(" \v\f<file>   \rCreate ", nil, true):depend(v70.home.presets, _depend.storage["local"]);
_menu.import = v53.home.preset_actions:button(" \v\f<file-import>   \rImport ", nil, true):depend(v70.home.presets, _depend.storage["local"]);
_menu.name = v53.home.preset_creation:input(""):depend(v70.home.presets, _depend.storage["local"], _menu.create);
_menu.create_final = v53.home.preset_creation:button("    \rCreate    "):depend(v70.home.presets, _depend.storage["local"], _menu.create);
_menu.create_cancel = v53.home.preset_creation:button("    \rCancel    ", nil, true):depend(v70.home.presets, _depend.storage["local"], _menu.create);
local function v272(v266)
    _menu.name:visibility(v266);
    _menu.create_final:visibility(v266);
    _menu.create_cancel:visibility(v266);
    local v267 = {
        [1] = _menu.storage, 
        [2] = _menu.settings, 
        [3] = _menu.local_presets, 
        [4] = _menu.local_actions.load, 
        [5] = _menu.local_actions.load_antiaims, 
        [6] = _menu.local_actions.copy, 
        [7] = _menu.local_actions.save, 
        [8] = _menu.local_actions.delete, 
        [9] = _menu.actions_label, 
        [10] = _menu.create, 
        [11] = _menu.import
    };
    for _, v269 in next, v267 do
        v269:visibility(not v266);
    end;
    for _, v271 in next, _menu.preset_information do
        v271.label:visibility(not v266);
        v271.button:visibility(not v266);
    end;
end;
do
    local l_v272_0 = v272;
    local function v274()
        -- upvalues: l_v272_0 (ref)
        l_v272_0(false);
    end;
    local function v275()
        -- upvalues: l_v272_0 (ref)
        l_v272_0(true);
    end;
    _menu.create:set_callback(v275);
    _menu.create_final:set_callback(v274);
    _menu.create_cancel:set_callback(v274);
end;
v272 = _menu.storage:list();
do
    local l_v230_2, l_v265_0, l_v272_1 = v230, v265, v272;
    local function v279()
        -- upvalues: l_v272_1 (ref)
        return _menu.storage.value == l_v272_1[1];
    end;
    local function v280()
        -- upvalues: l_v272_1 (ref)
        return _menu.storage.value == l_v272_1[2];
    end;
    local v281 = {};
    local v282 = {};
    do
        local l_v282_0 = v282;
        v281.create = function(_, v285, v286)
            -- upvalues: l_v282_0 (ref), v53 (ref), v70 (ref)
            assert(l_v282_0[v285] == nil, "same key already exist");
            local v287 = v53.home.preset_information:label(v286);
            local v288 = v53.home.preset_information:button("", nil, true);
            l_v282_0[v285] = {};
            _menu.preset_information[v285] = {
                label = v287, 
                button = v288
            };
            local function v289()
                -- upvalues: l_v282_0 (ref), v285 (ref)
                return l_v282_0[v285] and l_v282_0[v285].value ~= nil;
            end;
            local v290 = {
                [1] = v70.home.presets, 
                [2] = _menu.settings.show_info, 
                [3] = {
                    [1] = _menu.storage, 
                    [2] = v289
                }, 
                [4] = {
                    [1] = _menu.cloud_presets, 
                    [2] = v289
                }, 
                [5] = {
                    [1] = _menu.local_presets, 
                    [2] = v289
                }
            };
            v287:depend(unpack(v290));
            v288:depend(unpack(v290));
        end;
        v281.update = function(_, v292, v293)
            -- upvalues: l_v282_0 (ref), v280 (ref), v279 (ref)
            assert(l_v282_0[v292] ~= nil, "key not found");
            l_v282_0[v292].value = v293;
            _menu.preset_information[v292].button:name(v293 == nil and "" or tostring(v293));
            if v280() then
                _menu.local_presets:set(_menu.local_presets.value);
            end;
            if v279() then
                _menu.cloud_presets:set(_menu.cloud_presets.value);
            end;
        end;
    end;
    v281:create("likes", "\v\f<heart>    \rLikes");
    v281:create("loads", " \v\f<play>    \rLoads");
    v281:create("author", "\v\f<user>    \rAuthor");
    v281:create("script", "\v\f<brackets-curly>   \rScript");
    v281:create("relevance", "\v\f<code-branch>    \rRelevance");
    v281:create("last_update", "\v\f<floppy-disk>    \rLast Update");
    v282 = function()
        -- upvalues: l_base64_0 (ref), v225 (ref)
        local _, l_result_6 = pcall(function()
            -- upvalues: l_base64_0 (ref), v225 (ref)
            return l_base64_0.encode(json.stringify(v225.package:save()));
        end);
        return l_result_6;
    end;
    local function _(v296)
        -- upvalues: l_clipboard_0 (ref), l_base64_0 (ref)
        local v297 = pcall(function()
            -- upvalues: l_clipboard_0 (ref), l_base64_0 (ref), v296 (ref)
            l_clipboard_0.set(("evalate>%s<"):format(l_base64_0.encode(json.stringify(v296))));
        end);
        common.add_notify("Presets", v297 and "Preset successfully copied." or "Failed to copy preset.");
    end;
    local _ = {};
    local v300 = {};
    local v301 = {};
    do
        local l_v300_0, l_v301_0 = v300, v301;
        local function v305()
            -- upvalues: l_v301_0 (ref)
            local v304 = _menu.cloud_presets:get();
            return l_v301_0[v304], v304;
        end;
        local function v307()
            -- upvalues: v305 (ref), v281 (ref), l_pui_0 (ref), v2 (ref)
            local v306 = v305() or {};
            v281:update("author", v306.username);
            v281:update("script", v306.build_name);
            v281:update("likes", v306.likes);
            v281:update("loads", v306.loads);
            v281:update("last_update", v306.last_updated_at and common.get_date("%d.%m.%y %H:%M", v306.last_updated_at) or nil);
            v281:update("relevance", v306.build_version and l_pui_0.string(v306.build_version == v2 and " \a[green]\f<check>  \rUpdated " or " \a[red]\f<xmark>  \rOutdated ") or nil);
        end;
        v307();
        _menu.storage:set_callback(v307);
        _menu.cloud_presets:set_callback(v307);
        local function v311()
            -- upvalues: v305 (ref), v48 (ref)
            local v308, _ = v305();
            local v310 = v308 and v308.username == v48;
            _menu.cloud_actions.like:disabled(v308 == nil);
            _menu.cloud_actions.load:disabled(v308 == nil);
            _menu.cloud_actions.load_antiaims:disabled(v308 == nil);
            _menu.cloud_actions.save:disabled(v308 == nil or not v310);
            _menu.cloud_actions.delete:disabled(v308 == nil or not v310);
            _menu.cloud_actions.like:name(v308 and v308.liked and " \226\157\164\239\184\143 " or "  \f<heart>  ");
        end;
        _menu.cloud_presets:set_callback(v311);
        local function v317(v316)
            -- upvalues: l_v301_0 (ref), v315 (ref), v311 (ref), v307 (ref)
            l_v301_0 = v316 or {};
            v311();
            v307();
        end;
        local function v333(v318)
            -- upvalues: v48 (ref)
            local l_v318_0 = v318;
            local v320 = _menu.settings.filter:list();
            local v321 = _menu.settings.filter:get();
            if v321 ~= v320[1] then
                local v322 = {};
                for _, v324 in next, l_v318_0 do
                    if v321 == v320[2] and v324.username == v48 then
                        v322[#v322 + 1] = v324;
                    end;
                    if v321 == v320[3] and v324.liked then
                        v322[#v322 + 1] = v324;
                    end;
                end;
                l_v318_0 = v322;
            end;
            local v325 = _menu.settings.sort:list();
            local v326 = _menu.settings.sort:get();
            if v326 == v325[1] then
                table.sort(l_v318_0, function(v327, v328)
                    return v327.last_updated_at > v328.last_updated_at;
                end);
            end;
            if v326 == v325[2] then
                table.sort(l_v318_0, function(v329, v330)
                    return v329.likes > v330.likes;
                end);
            end;
            if v326 == v325[3] then
                table.sort(l_v318_0, function(v331, v332)
                    return v331.loads > v332.loads;
                end);
            end;
            return l_v318_0;
        end;
        local function v334()
            -- upvalues: v317 (ref), v333 (ref), l_v300_0 (ref)
            v317(v333(l_v300_0));
        end;
        _menu.settings.sort:set_callback(v334);
        _menu.settings.filter:set_callback(v334);
        local function v339()
            -- upvalues: v280 (ref), v317 (ref), l_v230_2 (ref), v48 (ref), v16 (ref), v5 (ref), v3 (ref), v6 (ref), l_v300_0 (ref), v333 (ref)
            if v280() then
                return;
            else
                v317({});
                _menu.cloud_presets:update(l_v230_2);
                local v335 = {
                    username = v48, 
                    timestamp = common.get_timestamp()
                };
                v335.signature = v16(v335, v5);
                network.post(v3 .. "/presets-recode/get", v335, v6, function(v336)
                    -- upvalues: l_v300_0 (ref), v317 (ref), v333 (ref)
                    local l_status_7, l_result_7 = pcall(json.parse, v336);
                    if not l_status_7 or not l_result_7 then
                        return print("Failed to fetch presets. Response: ", v336);
                    else
                        l_v300_0 = l_result_7;
                        v317(v333(l_result_7));
                        return;
                    end;
                end);
                return;
            end;
        end;
        _menu.storage:set_callback(v339, true);
        local function v348(v340)
            -- upvalues: v305 (ref), v225 (ref), l_base64_0 (ref), v48 (ref), v16 (ref), v5 (ref), v3 (ref), v6 (ref)
            local v341 = v305();
            if not v341 then
                return common.add_notify("Presets", "Preset not found.");
            else
                local function v346(v342)
                    -- upvalues: v225 (ref), l_base64_0 (ref), v340 (ref)
                    local l_status_8, l_result_8 = pcall(json.parse, v342);
                    if not l_status_8 or not l_result_8 or not l_result_8.status then
                        if l_result_8.message then
                            common.add_notify("Presets", l_result_8.message);
                        else
                            return print("Request failed. Response: ", v342);
                        end;
                    end;
                    local v345 = pcall(function()
                        -- upvalues: v225 (ref), l_base64_0 (ref), l_result_8 (ref), v340 (ref)
                        return v225.package:load(json.parse(l_base64_0.decode(l_result_8.data)), v340 and "antiaim" or nil);
                    end);
                    if v340 then
                        common.add_notify("Presets", v345 and "Anti-aim's successfully loaded from preset." or "Failed to load anti-aim's from preset.");
                    else
                        common.add_notify("Presets", v345 and "Preset successfully loaded." or "Failed to load preset.");
                    end;
                end;
                local v347 = {
                    username = v48, 
                    preset_author = v341.username, 
                    timestamp = common.get_timestamp()
                };
                v347.signature = v16(v347, v5);
                network.post(v3 .. "/presets-recode/load", v347, v6, v346);
                return;
            end;
        end;
        _menu.cloud_actions.load:set_callback(function()
            -- upvalues: v348 (ref)
            v348();
        end);
        _menu.cloud_actions.load_antiaims:set_callback(function()
            -- upvalues: v348 (ref)
            v348(true);
        end);
        local function v353()
            -- upvalues: v282 (ref), v48 (ref), l_RECODE_0 (ref), v2 (ref), v16 (ref), v5 (ref), v3 (ref), v6 (ref), v339 (ref)
            local v349 = {
                data = v282(), 
                username = v48, 
                build_name = l_RECODE_0, 
                build_version = v2, 
                timestamp = common.get_timestamp()
            };
            v349.signature = v16(v349, v5);
            network.post(v3 .. "/presets-recode/create", v349, v6, function(v350)
                -- upvalues: v339 (ref)
                local l_status_9, l_result_9 = pcall(json.parse, v350);
                if (not l_status_9 or not l_result_9 or not l_result_9.status) and not l_result_9.message then
                    return print("Request failed. Response: ", raw);
                else
                    if l_result_9.status then
                        v339();
                    end;
                    pcall(function()
                        -- upvalues: l_result_9 (ref)
                        common.add_notify("Presets", tostring(l_result_9.message));
                    end);
                    return;
                end;
            end);
        end;
        _menu.upload:set_callback(v353);
        local function v358()
            -- upvalues: v48 (ref), v16 (ref), v5 (ref), v3 (ref), v6 (ref), v339 (ref)
            local v354 = {
                username = v48, 
                timestamp = common.get_timestamp()
            };
            v354.signature = v16(v354, v5);
            network.post(v3 .. "/presets-recode/delete", v354, v6, function(v355)
                -- upvalues: v339 (ref)
                local l_status_10, l_result_10 = pcall(json.parse, v355);
                if (not l_status_10 or not l_result_10 or not l_result_10.status) and not l_result_10.message then
                    return print("Request failed. Response: ", raw);
                else
                    v339();
                    pcall(function()
                        -- upvalues: l_result_10 (ref)
                        common.add_notify("Presets", tostring(l_result_10.message));
                    end);
                    return;
                end;
            end);
        end;
        _menu.cloud_actions.delete:set_callback(v358);
        local function v363()
            -- upvalues: v282 (ref), v48 (ref), l_RECODE_0 (ref), v2 (ref), v16 (ref), v5 (ref), v3 (ref), v6 (ref), v339 (ref)
            local v359 = {
                data = v282(), 
                username = v48, 
                build_name = l_RECODE_0, 
                build_version = v2, 
                timestamp = common.get_timestamp()
            };
            v359.signature = v16(v359, v5);
            network.post(v3 .. "/presets-recode/update", v359, v6, function(v360)
                -- upvalues: v339 (ref)
                local l_status_11, l_result_11 = pcall(json.parse, v360);
                if (not l_status_11 or not l_result_11 or not l_result_11.status) and not l_result_11.message then
                    return print("Request failed. Response: ", raw);
                else
                    v339();
                    pcall(function()
                        -- upvalues: l_result_11 (ref)
                        common.add_notify("Presets", tostring(l_result_11.message));
                    end);
                    return;
                end;
            end);
        end;
        _menu.cloud_actions.save:set_callback(v363);
        local function v369()
            -- upvalues: v305 (ref), v48 (ref), v16 (ref), v5 (ref), v3 (ref), v6 (ref), v339 (ref)
            local v364 = v305();
            if not v364 then
                return;
            else
                local v365 = {
                    username = v48, 
                    preset_author = v364.username, 
                    timestamp = common.get_timestamp()
                };
                v365.signature = v16(v365, v5);
                network.post(v3 .. "/presets-recode/like", v365, v6, function(v366)
                    -- upvalues: v339 (ref)
                    local l_status_12, l_result_12 = pcall(json.parse, v366);
                    if (not l_status_12 or not l_result_12 or not l_result_12.status) and not l_result_12.message then
                        return print("Request failed. Response: ", raw);
                    else
                        v339();
                        pcall(function()
                            -- upvalues: l_result_12 (ref)
                            common.add_notify("Presets", tostring(l_result_12.message));
                        end);
                        return;
                    end;
                end);
                return;
            end;
        end;
        _menu.cloud_actions.like:set_callback(v369);
    end;
    v300 = {};
    v301 = "evalate_presets_19082378980123";
    local v370 = {};
    do
        local l_v301_1, l_v370_0 = v301, v370;
        local function v373()
            -- upvalues: l_v301_1 (ref)
            return db[l_v301_1] or {};
        end;
        local function v375(v374)
            -- upvalues: l_v301_1 (ref)
            db[l_v301_1] = v374;
        end;
        local function v377()
            -- upvalues: l_v370_0 (ref)
            local v376 = _menu.local_presets:get();
            return l_v370_0[v376], v376;
        end;
        local function v379()
            -- upvalues: v377 (ref), v281 (ref), l_pui_0 (ref), v2 (ref)
            local v378 = v377() or {};
            v281:update("author", v378.username);
            v281:update("script", v378.build_name);
            v281:update("likes");
            v281:update("loads");
            v281:update("last_update", v378.last_updated_at and common.get_date("%d.%m.%y %H:%M", v378.last_updated_at) or nil);
            v281:update("relevance", v378.build_version and l_pui_0.string(v378.build_version == v2 and " \a[green]\f<check>  \rUpdated " or " \a[red]\f<xmark>  \rOutdated ") or nil);
        end;
        _menu.local_presets:set_callback(v379, true);
        local function v381()
            -- upvalues: v377 (ref)
            local v380 = v377();
            _menu.local_actions.copy:disabled(v380 == nil);
            _menu.local_actions.load:disabled(v380 == nil);
            _menu.local_actions.load_antiaims:disabled(v380 == nil);
            _menu.local_actions.save:disabled(v380 == nil);
            _menu.local_actions.delete:disabled(v380 == nil);
        end;
        _menu.local_presets:set_callback(v381);
        local function v385()
            -- upvalues: l_v370_0 (ref), l_v265_0 (ref)
            local v382 = {};
            for _, v384 in next, l_v370_0 do
                v382[#v382 + 1] = v384.name;
            end;
            _menu.local_presets:update(#v382 > 0 and v382 or l_v265_0);
        end;
        local function v387(v386)
            -- upvalues: l_v370_0 (ref), v385 (ref), v381 (ref), v379 (ref)
            l_v370_0 = v386 or {};
            v385();
            v381();
            v379();
        end;
        local function v388()
            -- upvalues: v279 (ref), v387 (ref), v373 (ref)
            if v279() then
                return;
            else
                v387(v373());
                return;
            end;
        end;
        _menu.storage:set_callback(v388, true);
        local function v392()
            -- upvalues: v373 (ref), v225 (ref), v48 (ref), l_RECODE_0 (ref), v2 (ref), v375 (ref), v387 (ref)
            local v391 = pcall(function()
                -- upvalues: v373 (ref), v225 (ref), v48 (ref), l_RECODE_0 (ref), v2 (ref), v375 (ref), v387 (ref)
                local v389 = v373();
                local v390 = {
                    name = #_menu.name.value > 0 and _menu.name.value or string.format("Preset %s", #v389 + 1), 
                    data = v225.package:save(), 
                    last_updated_at = common.get_unixtime(), 
                    username = v48, 
                    build_name = l_RECODE_0, 
                    build_version = v2
                };
                table.insert(v389, 1, v390);
                v375(v389);
                v387(v373());
                _menu.name:set("");
            end);
            common.add_notify("Presets", v391 and "Preset successfully created." or "Failed to create preset.");
        end;
        _menu.create_final:set_callback(v392);
        local function v396()
            -- upvalues: v377 (ref), l_v370_0 (ref), v225 (ref), v375 (ref), v387 (ref)
            local _, v394 = v377();
            if not l_v370_0[v394] then
                return common.add_notify("Presets", "Preset not found.");
            else
                local v395 = pcall(function()
                    -- upvalues: l_v370_0 (ref), v394 (ref), v225 (ref), v375 (ref), v387 (ref)
                    l_v370_0[v394].data = v225.package:save();
                    l_v370_0[v394].last_updated_at = common.get_unixtime();
                    v375(l_v370_0);
                    v387(l_v370_0);
                end);
                common.add_notify("Presets", v395 and "Preset successfully saved." or "Failed to save preset.");
                return;
            end;
        end;
        _menu.local_actions.save:set_callback(v396);
        local function v400()
            -- upvalues: v377 (ref), l_v370_0 (ref), v375 (ref), v387 (ref), v373 (ref)
            local v399 = pcall(function()
                -- upvalues: v377 (ref), l_v370_0 (ref), v375 (ref), v387 (ref), v373 (ref)
                local _, v398 = v377();
                table.remove(l_v370_0, v398);
                v375(l_v370_0);
                v387(v373());
            end);
            common.add_notify("Presets", v399 and "Preset successfully deleted." or "Failed to delete preset.");
        end;
        _menu.local_actions.delete:set_callback(v400);
        local function v403()
            -- upvalues: v377 (ref), l_clipboard_0 (ref), l_base64_0 (ref)
            local v401 = v377();
            if not v401 then
                return common.add_notify("Presets", "Preset not found.");
            else
                local v402 = pcall(function()
                    -- upvalues: l_clipboard_0 (ref), l_base64_0 (ref), v401 (ref)
                    l_clipboard_0.set(("evalate>%s<"):format(l_base64_0.encode(json.stringify(v401))));
                end);
                common.add_notify("Presets", v402 and "Preset successfully copied." or "Failed to copy preset.");
                return;
            end;
        end;
        _menu.local_actions.copy:set_callback(v403);
        local function v407()
            -- upvalues: l_base64_0 (ref), l_clipboard_0 (ref), v373 (ref), v375 (ref), v387 (ref)
            local v406 = pcall(function()
                -- upvalues: l_base64_0 (ref), l_clipboard_0 (ref), v373 (ref), v375 (ref), v387 (ref)
                local v404 = json.parse(l_base64_0.decode(l_clipboard_0.get():match("evalate>(.-)<")));
                local v405 = v373();
                table.insert(v405, 1, v404);
                v375(v405);
                v387(v373());
            end);
            common.add_notify("Presets", v406 and "Preset successfully imported." or "Failed to import preset.");
        end;
        _menu.import:set_callback(v407);
        local function v410()
            -- upvalues: v377 (ref), v225 (ref)
            local v408 = v377();
            if not v408 then
                return common.add_notify("Presets", "Preset not found.");
            else
                local v409 = pcall(function()
                    -- upvalues: v225 (ref), v408 (ref)
                    return v225.package:load(v408.data);
                end);
                common.add_notify("Presets", v409 and "Preset successfully loaded." or "Failed to load preset.");
                return;
            end;
        end;
        _menu.local_actions.load:set_callback(v410);
        local function v413()
            -- upvalues: v377 (ref), v225 (ref)
            local v411 = v377();
            if not v411 then
                return common.add_notify("Presets", "Preset not found.");
            else
                local v412 = pcall(function()
                    -- upvalues: v225 (ref), v411 (ref)
                    return v225.package:load(v411.data, "antiaim");
                end);
                common.add_notify("Presets", v412 and "Anti-aim's from preset successfully loaded." or "Failed to anti-aim's from preset.");
                return;
            end;
        end;
        _menu.local_actions.load_antiaims:set_callback(v413);
    end;
end;
v226 = nil;
v230 = function(v414, v415, v416)
    local v417 = 3 * v414;
    local v418 = 3 * (v415 - v414) - v417;
    return (((1 - v417 - v418) * v416 + v418) * v416 + v417) * v416;
end;
v265 = function(v419, v420, v421)
    local v422 = 3 * v419;
    local v423 = 3 * (v420 - v419) - v422;
    return (3 * (1 - v422 - v423) * v421 + 2 * v423) * v421 + v422;
end;
do
    local l_v230_3, l_v265_1 = v230, v265;
    v272 = function(v426, v427, v428, v429)
        -- upvalues: l_v230_3 (ref), l_v265_1 (ref)
        return function(v430)
            -- upvalues: l_v230_3 (ref), v426 (ref), v428 (ref), l_v265_1 (ref), v427 (ref), v429 (ref)
            local l_v430_0 = v430;
            local l_v430_1 = v430;
            for _ = 1, 5 do
                local v434 = l_v230_3(v426, v428, l_v430_1) - l_v430_0;
                local v435 = l_v265_1(v426, v428, l_v430_1);
                if math.abs(v434) >= 1.0E-5 and math.abs(v435) >= 1.0E-5 then
                    l_v430_1 = l_v430_1 - v434 / v435;
                else
                    break;
                end;
            end;
            return l_v230_3(v427, v429, l_v430_1);
        end;
    end;
    local function v437(v436)
        return v436;
    end;
    local function v441(v438, v439, v440)
        if type(v438) == "number" and type(v439) == "number" then
            return v438 + (v439 - v438) * v440;
        elseif type(v438) == "userdata" and v438.__name and (v438.__name == "sol.Vector" or v438.__name == "sol.ImColor") and type(v439) == "userdata" and v439.__name and (v439.__name == "sol.Vector" or v439.__name == "sol.ImColor") then
            return v438:lerp(v439, v440);
        else
            error("Unsupported types for lerp: " .. type(v438));
            return;
        end;
    end;
    __call = function(v442, v443, v444, v445)
        -- upvalues: v441 (ref)
        local v446 = v444 or 0.25;
        local v447 = v445 or v442.default;
        local v448 = v443 or 0;
        local v449 = {
            active = false, 
            time = 0, 
            from = v448, 
            to = v448, 
            value = v448
        };
        return function(v450)
            -- upvalues: v449 (ref), v446 (ref), v441 (ref), v447 (ref)
            if type(v450) == "boolean" then
                v450 = v450 and 1 or 0;
            end;
            if v450 ~= nil and v450 ~= v449.to then
                v449.from = v449.value;
                v449.to = v450;
                v449.time = 0;
                v449.active = true;
            end;
            if v449.active then
                v449.time = math.min(v449.time + globals.frametime, v446);
                local v451 = v449.time / v446;
                v449.value = v441(v449.from, v449.to, v447(v451));
                if v451 >= 1 then
                    v449.active = false;
                end;
            end;
            return v449.value;
        end;
    end;
    v226 = setmetatable({
        linear = v437, 
        ease_in = v272(0.42, 0, 1, 1), 
        ease_out = v272(0, 0, 0.58, 1), 
        ease_in_out = v272(0.42, 0, 0.58, 1), 
        bezier_easing = v272, 
        default = v272(0.34, 1.6, 0.64, 1)
    }, {
        __call = __call
    });
end;
v230 = function(v452)
    local l_status_13, l_result_13 = pcall(function()
        -- upvalues: v452 (ref)
        return v452[0];
    end);
    return l_status_13 and l_result_13 ~= nil;
end;
v265 = {};
v272 = v226();
v265.players = {};
local v455 = 0;
do
    local l_v272_2, l_v455_0 = v272, v455;
    local function v470()
        -- upvalues: v265 (ref), l_v455_0 (ref)
        local l_me_0 = v265.me;
        local l_eye_0 = v265.eye;
        local l_threat_0 = v265.threat;
        local l_velocity_0 = v265.velocity;
        local l_camera_angles_0 = v265.camera_angles;
        local l_tickcount_1 = globals.tickcount;
        if l_tickcount_1 < l_v455_0 + 20 then
            return;
        elseif not l_me_0 or not l_eye_0 or not l_threat_0 or not l_velocity_0 or l_velocity_0 < 2 or not l_camera_angles_0 or l_threat_0:is_visible() then
            v265.on_peek = false;
            v265.peek_yaw = nil;
            return;
        else
            local v464 = l_me_0:simulate_movement();
            v464:think(13);
            local v465 = l_threat_0:get_hitbox_position(6);
            local v467, v468 = utils.trace_bullet(l_me_0, vector(v464.origin.x, v464.origin.y, l_eye_0.z), v465, function(v466)
                return v466:is_player() and v466:is_enemy();
            end);
            if v467 > 0 and v468.entity == l_threat_0 then
                local v469 = (v468.start_pos - l_eye_0):angles().y - l_camera_angles_0.y + 180;
                v265.on_peek = true;
                v265.peek_yaw = v469;
                l_v455_0 = l_tickcount_1;
            else
                v265.on_peek = false;
                v265.peek_yaw = nil;
            end;
            return;
        end;
    end;
    local function v473()
        -- upvalues: v265 (ref), v470 (ref)
        v265.threat = entity.get_threat();
        v265.me = entity.get_local_player();
        v265.is_alive = v265.me and v265.me:is_alive();
        v265.origin = v265.me and v265.me:get_origin();
        v265.eye = v265.me and v265.me:get_eye_position();
        v265.weapon = v265.me and v265.me:get_player_weapon();
        v265.weapons = v265.me and v265.me:get_player_weapon(true);
        v265.weapon_info = v265.weapon and v265.weapon:get_weapon_info();
        v265.anim_state = v265.me and v265.me:get_anim_state();
        v265.velocity = v265.anim_state and v265.anim_state.velocity:length();
        v265.is_scoped = v265.me and v265.me.m_bIsScoped;
        v265.players = {};
        for _, v472 in ipairs(entity.get_players()) do
            v265.players[#v265.players + 1] = {
                entity = v472, 
                is_enemy = v472:is_enemy(), 
                is_alive = v472:is_alive(), 
                is_dormant = v472:is_dormant()
            };
        end;
        v265.game_rules = entity.get_game_rules();
        v265.is_warmup = v265.game_rules and v265.game_rules.m_bWarmupPeriod;
        v265.exploit_charge = rage.exploit:get();
        v470();
    end;
    local function v474()
        -- upvalues: v265 (ref), v52 (ref), l_v272_2 (ref)
        v265.binds = ui.get_binds();
        v265.ui_size = ui.get_size();
        v265.ui_alpha = ui.get_alpha();
        v265.ui_position = ui.get_position();
        v265.mouse_position = ui.get_mouse_position();
        v265.camera_angles = render.camera_angles();
        v265.is_min_damage = v52:is_min_damage();
        v265.is_double_tap = v52.double_tap:get();
        v265.is_hide_shots = v52.hide_shots:get();
        v265.is_slow_walk = v52.slow_walk:get();
        v265.realtime = globals.realtime;
        v265.absoluteframetime = globals.absoluteframetime;
        v265.anim_scoped = l_v272_2(v265.is_scoped);
        v265.pulse = math.abs(v265.realtime * 1.5 % 2 - 1);
    end;
    local v475 = 0;
    local function v478()
        -- upvalues: v265 (ref), v475 (ref)
        v265.net_channel = utils.net_channel();
        if v265.net_channel then
            v265.server_info = v265.net_channel:get_server_info();
        end;
        local v476 = entity.get_local_player();
        if v476 then
            local l_m_nTickBase_0 = v476.m_nTickBase;
            if math.abs(l_m_nTickBase_0 - v475) > 64 then
                v475 = 0;
            end;
            v265.defensive_ticks_left = 0;
            if v475 < l_m_nTickBase_0 then
                v475 = l_m_nTickBase_0;
            elseif l_m_nTickBase_0 < v475 then
                v265.defensive_ticks_left = math.min(14, math.max(0, v475 - l_m_nTickBase_0 - 1));
            end;
            v265.is_defensive = v265.defensive_ticks_left > 0;
        end;
    end;
    v474();
    v478();
    v473();
    events.render(v474);
    events.createmove(v478);
    events.pre_render(v473);
    events.createmove(v473);
    events.level_init(v473);
end;
v272 = nil;
v455 = l_pui_0.accent:clone();
local v479 = {
    Static = {
        [1] = v455
    }, 
    Rainbow = {
        [1] = v455
    }
};
local v480 = v53.features.settings:switch("\v\f<paintbrush>   \rAccent color", false, "Enable to use custom color", v479);
v480.color:depend(v480);
v51.new("accent", v480, v70.features.visual);
do
    local l_v480_0 = v480;
    local function v488()
        -- upvalues: l_v480_0 (ref), v265 (ref)
        local v482, v483 = l_v480_0.color:get();
        if v482 == "Rainbow" then
            local _, v485, v486 = v483:to_hsv();
            local v487 = color():as_hsv(v265.realtime % 3 / 3, v485, v486, v483.a / 255);
            l_v480_0.color:set("Rainbow", {
                [1] = v487
            });
        end;
    end;
    local l_v455_1 = v455;
    local function v492()
        -- upvalues: l_v480_0 (ref), l_v455_1 (ref), l_pui_0 (ref)
        local _, v491 = l_v480_0.color:get();
        l_v455_1 = l_v480_0:get() and v491:clone() or l_pui_0.accent:clone();
    end;
    v272 = function()
        -- upvalues: l_v455_1 (ref)
        return l_v455_1:clone();
    end;
    local function v493()
        -- upvalues: l_pui_0 (ref), v272 (ref)
        l_pui_0.colors.accent = v272();
    end;
    events.render(function()
        -- upvalues: v492 (ref), v493 (ref), v488 (ref)
        v492();
        v493();
        v488();
    end);
end;
v455 = 1;
v479 = "";
v480 = {
    blur = true, 
    shadow = true, 
    blur_alpha = 1, 
    shadow_alpha = 1
};
local v495 = v53.features.settings:label("\v\f<bars>    \rSettings", nil, function(v494)
    return {
        dpi = v494:switch("\v\f<font>   \rScaling"), 
        blur = v494:switch("\v\f<droplet>    \rBlur", true), 
        shadow = v494:switch("\v\f<brightness>   \rGlow", true)
    };
end);
v495:depend(v70.features.visual);
v495.blur:tooltip("\v\f<circle-info>   \rProblems with FPS? Turn it off!");
v495.shadow:tooltip("\v\f<circle-info>   \rProblems with FPS? Turn it off!");
do
    local l_v495_0 = v495;
    l_v495_0.blur:set_callback(function()
        -- upvalues: v480 (ref), l_v495_0 (ref)
        v480.blur = l_v495_0.blur.value;
    end, true);
    l_v495_0.shadow:set_callback(function()
        -- upvalues: v480 (ref), l_v495_0 (ref)
        v480.shadow = l_v495_0.shadow.value;
    end, true);
    local v497 = v226(v480.blur_alpha, nil, v226.ease_in_out);
    local v498 = v226(v480.shadow_alpha, nil, v226.ease_in_out);
    events.render(function()
        -- upvalues: v455 (ref), l_v495_0 (ref), v479 (ref), v480 (ref), v497 (ref), v498 (ref)
        v455 = l_v495_0.dpi.value and render.get_scale(2) or 1;
        v479 = l_v495_0.dpi.value and "s" or "";
        v480.blur_alpha = v497(l_v495_0.blur.value);
        v480.shadow_alpha = v498(l_v495_0.shadow.value);
    end);
    local l_text_0 = render.text;
    render.text = function(v500, v501, v502, v503, ...)
        -- upvalues: l_text_0 (ref), v479 (ref)
        l_text_0(v500, v501, v502, v503 and v503 .. v479 or v479, ...);
    end;
    local l_blur_0 = render.blur;
    render.blur = function(v505, v506, v507, v508, ...)
        -- upvalues: v480 (ref), l_blur_0 (ref)
        if not v480.blur and v480.blur_alpha <= 0 then
            return;
        else
            l_blur_0(v505, v506, v507, v508 * v480.blur_alpha, ...);
            return;
        end;
    end;
    local l_shadow_0 = render.shadow;
    render.shadow = function(v510, v511, v512, v513, ...)
        -- upvalues: v480 (ref), l_shadow_0 (ref)
        if not v480.shadow and v480.shadow_alpha <= 0 then
            return;
        else
            l_shadow_0(v510, v511, v512:alpha_modulate(v512.a * v480.shadow_alpha), v513 * v480.shadow_alpha, ...);
            return;
        end;
    end;
end;
v495 = {
    layout = {
        shadow_spread = 70, 
        rounding = 12, 
        height = 12, 
        padding = vector(25, 13)
    }, 
    fonts = {
        header = render.load_font("arial", 14, "ad"), 
        content = render.load_font("arial", vector(13, 11), "a")
    }, 
    colors = {
        rect = {
            outline = color(255, 20), 
            background = color(150, 40)
        }, 
        text = {
            primary = color(240), 
            secondary = color(170)
        }
    }
};
v495.render_rect = function(v514, v515, v516, v517, v518)
    -- upvalues: v495 (ref), v455 (ref), v480 (ref)
    local v519 = v495.layout.height * v455;
    local v520 = v495.layout.padding * v455;
    local v521 = v495.layout.rounding * v455;
    local v522 = v495.layout.shadow_spread * v455;
    local v523 = (v514 + vector(v520.x / 2, v519 / 2 + v520.y / 2)):floor();
    local v524 = math.max(1, (v518 or v519) / 16) - 1;
    local v525 = vector(v517, 2 + 16 * v524):floor();
    if v480.shadow_alpha > 0 then
        render.rect(v523, v523 + v525, v515:alpha_modulate(65 * v516 * v480.shadow_alpha), v521);
    end;
    render.shadow(v523, v523 + v525, v515:alpha_modulate(255 * v516), v522, 0, v521);
    render.blur(v514, v514 + v520 + vector(v517, v518 or v519), 0, v516, v521);
    render.rect(v514, v514 + v520 + vector(v517, v518 or v519), v495.colors.rect.background:alpha_modulate(v495.colors.rect.background.a * v516), v521);
    render.rect_outline(v514, v514 + v520 + vector(v517, v518 or v519), v495.colors.rect.outline:alpha_modulate(v495.colors.rect.outline.a * v516), 1, v521);
end;
v495.render_text_header = function(v526, v527, v528, ...)
    -- upvalues: v495 (ref)
    render.text(v495.fonts.header, v526, v527, v528, ...);
end;
v495.render_text_content = function(v529, v530, v531, ...)
    -- upvalues: v495 (ref)
    render.text(v495.fonts.content, v529, v530, v531, ...);
end;
local function v536(v532, v533, v534)
    -- upvalues: v265 (ref)
    local v535 = v532 + (v533 - v532) * v265.absoluteframetime * v534;
    return math.abs(v533 - v535) < 0.005 and v533 or v535;
end;
local v537 = nil;
local v538 = setmetatable({}, {
    __mode = "kv"
});
do
    local l_v538_0 = v538;
    v537 = function(v540, v541, v542)
        -- upvalues: l_v538_0 (ref), v479 (ref)
        local v543 = string.format("%s:%s:%s", v540, v541, v542);
        if l_v538_0[v543] == nil or l_v538_0[v543].x == 0 then
            l_v538_0[v543] = render.measure_text(v540, v541 and v541 .. v479 or v479, v542);
        end;
        return l_v538_0[v543];
    end;
end;
v538 = {};
local v544 = nil;
local v545 = nil;
do
    local l_v544_0, l_v545_0 = v544, v545;
    events.mouse_input(function()
        -- upvalues: l_v544_0 (ref), l_v545_0 (ref)
        if l_v544_0 or l_v545_0 then
            return false;
        else
            return;
        end;
    end);
    local function v550(v548, v549)
        -- upvalues: v265 (ref)
        return v265.mouse_position.x >= v548.x and v265.mouse_position.x <= v548.x + v549.x and v265.mouse_position.y >= v548.y and v265.mouse_position.y <= v548.y + v549.y;
    end;
    local v551 = l_pui_0.create("evalate-dragger");
    local v552 = 10000;
    v538.new = function(v553, v554, v555)
        -- upvalues: v551 (ref), v552 (ref), v49 (ref), v226 (ref), v265 (ref), v550 (ref), l_v544_0 (ref), v39 (ref), l_v545_0 (ref), v455 (ref), v51 (ref)
        local v593 = {
            dragging = false, 
            action = false, 
            hover = false, 
            last_mouse_position = vector(), 
            size = v555, 
            position = v554, 
            reference = {
                px = v551:slider(string.format("drag[%s].px", v553), -v552, v552, math.floor(v554.x / v49.x * v552)), 
                py = v551:slider(string.format("drag[%s].py", v553), -v552, v552, math.floor(v554.y / v49.y * v552))
            }, 
            get_position = function(v556)
                -- upvalues: v552 (ref), v49 (ref)
                local v557 = v556.reference.px:get() / v552;
                local v558 = v556.reference.py:get() / v552;
                return vector(v557 * v49.x, v558 * v49.y);
            end, 
            set_limit = function(v559, v560, v561)
                v559.limit = {
                    size = v561, 
                    position = v560
                };
            end, 
            lines = {}, 
            add_line = function(v562, v563, v564)
                v562.lines[#v562.lines + 1] = {
                    position = v563, 
                    horizontal = v564
                };
            end, 
            anim_box_alpha = v226(0, 0.15, v226.ease_in_out), 
            anim_line_alpha = v226(0, 0.15, v226.ease_in_out), 
            anim_box_border_alpha = v226(0, 0.15, v226.ease_in_out), 
            update = function(v565, v566, v567, v568)
                -- upvalues: v265 (ref), v550 (ref), l_v544_0 (ref), v553 (ref), v39 (ref), v49 (ref), v552 (ref), l_v545_0 (ref), v455 (ref)
                local v569 = v265.ui_alpha * v566;
                local l_mouse_position_0 = v265.mouse_position;
                local v571 = v265.ui_alpha > 0;
                local v572 = common.is_button_down(1);
                local l_ui_size_0 = v265.ui_size;
                local l_ui_position_0 = v265.ui_position;
                local v575 = v550(l_ui_position_0, l_ui_size_0);
                if v567 then
                    v565.size = v567;
                end;
                v565.position = v565:get_position();
                v565.hover = v550(v565.position, v565.size) and not v575;
                v565.action = v565.dragging or v565.hover;
                if v565.action and v572 and v571 and (l_v544_0 == v553 or l_v544_0 == nil) then
                    local v576 = nil;
                    local v577 = nil;
                    if #v565.lines > 0 then
                        for _, v579 in ipairs(v565.lines) do
                            local v580 = 10;
                            local v581 = math.abs(v579.position.x - v565.position.x - v565.size.x / 2);
                            local v582 = math.abs(v579.position.y - v565.position.y - v565.size.y / 2);
                            if v579.horizontal then
                                if not v577 and v582 < v580 then
                                    v577 = v579.position.y - v565.size.y / 2;
                                    if not v565.last_mouse_stick then
                                        v565.last_mouse_stick = l_mouse_position_0;
                                    end;
                                end;
                                if v577 and v565.last_mouse_stick and v580 < math.abs(v565.last_mouse_stick.y - l_mouse_position_0.y) then
                                    v577 = nil;
                                    v565.last_mouse_stick = nil;
                                end;
                            else
                                if not v576 and v581 < v580 then
                                    v576 = v579.position.x - v565.size.x / 2;
                                    if not v565.last_mouse_stick then
                                        v565.last_mouse_stick = l_mouse_position_0;
                                    end;
                                end;
                                if v576 and v565.last_mouse_stick and v580 < math.abs(v565.last_mouse_stick.x - l_mouse_position_0.x) then
                                    v576 = nil;
                                    v565.last_mouse_stick = nil;
                                end;
                            end;
                        end;
                    end;
                    local v583 = l_mouse_position_0 + v565.last_mouse_position;
                    local l_vector_0 = vector;
                    local v585;
                    if not v576 or not v576 then
                        v585 = v583.x;
                    else
                        v585 = v576;
                    end;
                    local v586;
                    if not v577 or not v577 then
                        v586 = v583.y;
                    else
                        v586 = v577;
                    end;
                    l_vector_0 = l_vector_0(v585, v586);
                    v585 = v39(l_vector_0, vector(), v49 - v565.size);
                    if v565.limit then
                        v585 = v39(v585, v565.limit.position, v565.limit.position + v565.limit.size - v565.size);
                    end;
                    v565.reference.px:set(math.floor(v585.x / v49.x * v552));
                    v565.reference.py:set(math.floor(v585.y / v49.y * v552));
                    v565.dragging = true;
                    l_v544_0 = v553;
                else
                    v565.last_mouse_position = v565.position - l_mouse_position_0;
                    v565.dragging = false;
                    if l_v544_0 == v553 then
                        l_v544_0 = nil;
                    end;
                end;
                if v565.hover and v571 then
                    l_v545_0 = v553;
                elseif l_v545_0 == v553 then
                    l_v545_0 = nil;
                end;
                local v587 = v565.anim_box_alpha(v565.action and 30 or 20) * v569;
                local v588 = v565.anim_line_alpha(v565.action and 40 or 0) * v569;
                local v589 = v565.anim_box_border_alpha(v565.dragging and 40 or 0) * v569;
                if v569 > 0 then
                    local v590 = (v568 or 16) * v455;
                    if v565.limit then
                        render.rect_outline(v565.limit.position, v565.limit.position + v565.limit.size, color(255, v588), 1, v590);
                    end;
                    if #v565.lines > 0 then
                        for _, v592 in ipairs(v565.lines) do
                            if v592.horizontal then
                                render.rect(v592.position, v592.position + vector(v49.x, 1), color());
                            else
                                render.rect(v592.position, v592.position + vector(1, v49.y), color());
                            end;
                        end;
                    end;
                    if v587 > 0 then
                        render.rect(v565.position, v565.position + v565.size, color(255, v587), v590);
                    end;
                    if v589 > 0 then
                        render.rect_outline(v565.position, v565.position + v565.size, color(255, v589), 1, v590);
                    end;
                end;
            end
        };
        local function v594()
            -- upvalues: v593 (ref)
            v593.reference.px:set_visible(false);
            v593.reference.py:set_visible(false);
        end;
        v594();
        v593.reference.px:set_callback(v594);
        v593.reference.py:set_callback(v594);
        v51.new(string.format("drag[%s].xy", v553), v593.reference);
        return v593;
    end;
    v538.new_offset = function(v595, v596, v597, v598, v599, v600, v601)
        -- upvalues: v551 (ref), v552 (ref), v226 (ref), v265 (ref), v550 (ref), l_v544_0 (ref), v35 (ref), l_v545_0 (ref), v455 (ref), v51 (ref)
        local v620 = {
            action = false, 
            dragging = false, 
            hover = false, 
            last_mouse_position = vector(), 
            size = v597, 
            position = v596, 
            offset = v598, 
            max_offset = v599, 
            horizontal = v600, 
            reference = {
                offset = v551:slider(string.format("drag[%s].offset", v595), -v552, v552, v598)
            }, 
            get_offset = function(v602)
                return v602.reference.offset:get();
            end, 
            anim_box_alpha = v226(0, 0.15, v226.ease_in_out), 
            anim_line_alpha = v226(0, 0.15, v226.ease_in_out), 
            anim_box_border_alpha = v226(0, 0.15, v226.ease_in_out), 
            update = function(v603, v604, v605, v606)
                -- upvalues: v265 (ref), v550 (ref), l_v544_0 (ref), v595 (ref), v35 (ref), l_v545_0 (ref), v599 (ref), v455 (ref), v601 (ref)
                local v607 = v265.ui_alpha * v604;
                local l_mouse_position_1 = v265.mouse_position;
                local v609 = v265.ui_alpha > 0;
                local v610 = common.is_button_down(1);
                local l_ui_size_1 = v265.ui_size;
                local l_ui_position_1 = v265.ui_position;
                local v613 = v550(l_ui_position_1, l_ui_size_1);
                if v605 then
                    v603.size = v605;
                end;
                v603.offset = v603:get_offset();
                v603.hover = (v603.horizontal and v550(v603.position - v603.size / 2 + vector(v603.offset, 0), v603.size) or v550(v603.position + vector(-(v603.size.x / 2), v603.offset), v603.size)) and not v613;
                v603.action = v603.dragging or v603.hover;
                if v603.action and v610 and v609 and (l_v544_0 == v595 or l_v544_0 == nil) then
                    if v603.horizontal then
                        v603.reference.offset:set(v35(-(v603.position.x - (l_mouse_position_1.x + v603.last_mouse_position.x)), 0, v603.max_offset));
                    else
                        v603.reference.offset:set(v35(-(v603.position.y - (l_mouse_position_1.y + v603.last_mouse_position.y)), 0, v603.max_offset));
                    end;
                    v603.dragging = true;
                    l_v544_0 = v595;
                else
                    v603.last_mouse_position = v603.horizontal and v603.position - l_mouse_position_1 + vector(v603.offset, 0) or v603.position - l_mouse_position_1 + vector(0, v603.offset);
                    v603.dragging = false;
                    if l_v544_0 == v595 then
                        l_v544_0 = nil;
                    end;
                end;
                if v603.hover and v609 then
                    l_v545_0 = v595;
                elseif l_v545_0 == v595 then
                    l_v545_0 = nil;
                end;
                local v614 = v603.anim_box_alpha(v603.action and 30 or 20) * v607;
                local v615 = v603.anim_line_alpha(v603.action and 40 or 0) * v607;
                local v616 = v603.anim_box_border_alpha(v603.dragging and 40 or 0) * v607;
                if v607 > 0 then
                    if v615 > 0 then
                        local v617 = v603.horizontal and vector(v599, 1) or vector(1, v599);
                        render.rect(v603.position, v603.position + v617, color(255, v615));
                    end;
                    local v618 = (v606 or 16) * v455;
                    local v619 = v603.position - (v601 and v603.size / 2 or vector(v603.size.x / 2, 0)) + (v603.horizontal and vector(v603.offset, 0) or vector(0, v603.offset));
                    if v614 > 0 then
                        render.rect(v619, v619 + v603.size, color(255, v614), v618);
                    end;
                    if v616 > 0 then
                        render.rect_outline(v619, v619 + v603.size, color(255, v616), 1, v618);
                    end;
                end;
            end
        };
        local function v621()
            -- upvalues: v620 (ref)
            v620.reference.offset:set_visible(false);
        end;
        v621();
        v620.reference.offset:set_callback(v621);
        v51.new(string.format("drag[%s].offset", v595), v620.reference.offset);
        return v620;
    end;
end;
v50 = {};
v544 = v53.features.widgets:switch("\v\f<bell>     \rNotifications", false, nil, function(v622)
    return {
        debug = v622:switch("\v\f<fingerprint>     \rDebug"), 
        screen = v622:switch("\v\f<screencast>    \rScreen"), 
        console = v622:switch("\v\f<terminal>    \rConsole")
    }, true;
end);
v51.new("notifications", v544, v70.features.visual);
v545 = v49.y / 1.7;
local v623 = v538.new_offset("notifications", vector(v49.x / 2, v545), vector(200, 30), 50, v49.y / 1.1 - v545, false);
local v624 = {
    default = {}, 
    preview = {}
};
local v625 = 5;
local v626 = 5;
local v627 = false;
local v628 = false;
local v629 = false;
local v630 = false;
local v631 = {
    spread = color("edc477"), 
    correction = color("ff5d52"), 
    misprediction = color("ff5d52"), 
    ["prediction error"] = color("ff5d52"), 
    ["damage rejection"] = color("ff5d52"), 
    ["backtrack failure"] = color("7a9ffa"), 
    death = color("8c8c8c"), 
    ["player death"] = color("8c8c8c"), 
    ["unregistered shot"] = color("8c8c8c")
};
local v632 = {
    [0] = "generic", 
    [1] = "head", 
    [2] = "chest", 
    [3] = "stomach", 
    [4] = "left arm", 
    [5] = "right arm", 
    [6] = "left leg", 
    [7] = "right leg", 
    [8] = "neck", 
    [9] = "generic", 
    [10] = "gear"
};
local v633 = {
    inferno = "Burned", 
    knife = "Knifed", 
    hegrenade = "Naded", 
    taser = "Tased"
};
local v634 = {
    inferno = "Burned", 
    knife = "Stabbed", 
    hegrenade = "Exploded", 
    taser = "Tased"
};
v50.center = function(v635, v636, v637, v638)
    -- upvalues: v272 (ref), v455 (ref), v495 (ref), v537 (ref)
    local v639 = v636 or v272();
    local v640 = vector(10, 0) * v455;
    local v641 = v495.layout.padding * v455;
    local v642 = v537(v495.fonts.content, nil, v638) + v640;
    local v643 = v635 - vector(v641.x / 2 + v642.x / 2, 0);
    v495.render_rect(v643, v639, v637, v642.x);
    v495.render_text_content(v643 + v640 + v641 / 2, color(255, 255 * v637), nil, v638);
    local v644 = v643 + vector(13, 12) * v455;
    render.circle(v644, v639:alpha_modulate(75 * v637), 4 * v455, 0, 1 * v455);
    render.circle(v644, v639:alpha_modulate(255 * v637), 2 * v455, 0, 1 * v455);
    return v642.x;
end;
do
    local l_v544_1, l_v623_0, l_v624_0, l_v625_0, l_v626_0, l_v627_0, l_v628_0, l_v629_0, l_v630_0, l_v631_0, l_v632_0, l_v633_0, l_v634_0 = v544, v623, v624, v625, v626, v627, v628, v629, v630, v631, v632, v633, v634;
    v50.screen = function(v658, v659)
        -- upvalues: l_v624_0 (ref), v226 (ref), l_v628_0 (ref), v265 (ref)
        if v659 then
            table.insert(l_v624_0.preview, 1, {
                alpha = 0, 
                animate = v226(), 
                callback = v658
            });
            return l_v624_0.preview[1];
        elseif l_v628_0 then
            table.insert(l_v624_0.default, 1, {
                alpha = 0, 
                animate = v226(), 
                realtime = v265.realtime, 
                callback = v658
            });
            return l_v624_0.default[1];
        else
            return {
                realtime = v265.realtime
            };
        end;
    end;
    v50.print = function(v660)
        -- upvalues: l_pui_0 (ref), l_v627_0 (ref), l_v629_0 (ref)
        local v661 = l_pui_0.string("\a[accent]evalate\a[inactive] \226\128\186 \r");
        if l_v627_0 then
            print_dev(v661 .. tostring(v660));
        end;
        if l_v629_0 then
            print_raw(v661 .. tostring(v660));
        end;
    end;
    v50.build = function(v662, v663, v664)
        -- upvalues: v272 (ref), l_pui_0 (ref)
        local v665 = "\a" .. (v663 or v272()):to_hex();
        local v666 = "\a[inactive]";
        local v667 = v666 .. tostring(v662);
        for v668, v669 in pairs(v664) do
            local v670 = "{" .. tostring(v668) .. "}";
            local v671 = v665 .. tostring(v669) .. v666;
            v667 = v667.gsub(v667, v670, v671);
        end;
        return l_pui_0.string(v667);
    end;
    local v672 = v226();
    local v673 = v226();
    local v674 = 100;
    local v675 = nil;
    v675 = function()
        -- upvalues: l_v630_0 (ref), l_v628_0 (ref), v672 (ref), v72 (ref), v675 (ref), v673 (ref), v674 (ref), v495 (ref), v455 (ref), l_v623_0 (ref), l_v624_0 (ref), v265 (ref), l_v626_0 (ref), l_v625_0 (ref)
        local v676 = l_v630_0 and l_v628_0;
        local v677 = v672(v676);
        if not v676 and v677 <= 0 then
            if not l_v630_0 or not l_v628_0 then
                v72("render", v675);
            end;
            return;
        else
            local v678 = v673(v674);
            local v679 = vector(v678 + v495.layout.padding.x * v455 + 8 * v455, 33 * v455);
            l_v623_0:update(v677, v679);
            local v680 = vector(l_v623_0.position.x, l_v623_0.position.y + l_v623_0.offset + 4 * v455);
            local v681 = 0;
            if #l_v624_0.default > 0 then
                for v682, v683 in ipairs(l_v624_0.default) do
                    local v684 = v265.realtime > v683.realtime + l_v626_0;
                    if v683.alpha > 0 then
                        local v685 = v683:callback(vector(v680.x, v680.y + 33 * v455 * v681));
                        if v682 == 1 then
                            v674 = v685;
                        end;
                    end;
                    v683.alpha = v683.animate(not v684) * v677;
                    v681 = v681 + v683.alpha;
                    if #l_v624_0.default > l_v625_0 then
                        table.remove(l_v624_0.default);
                    end;
                    if v684 and v683.alpha <= 0 then
                        table.remove(l_v624_0.default, v682);
                    end;
                end;
            else
                for v686, v687 in ipairs(l_v624_0.preview) do
                    if v687.alpha > 0 then
                        local v688 = v687:callback(vector(v680.x, v680.y + 33 * v455 * v681));
                        if v686 == 1 then
                            v674 = v688;
                        end;
                    end;
                    v687.alpha = v687.animate(v265.ui_alpha > 0) * v677;
                    v681 = v681 + v687.alpha;
                end;
            end;
            return;
        end;
    end;
    local function v693(v689, v690)
        -- upvalues: v272 (ref), v50 (ref)
        local v691 = v272();
        local v692 = v50.build("your face is like a {melody} - it won't leave my {head}", v691, {
            head = "head", 
            melody = "melody"
        });
        return v50.center(v690, v691, v689.alpha, v692);
    end;
    v50.screen(v693, true);
    v693 = function(v694, v695)
        -- upvalues: v272 (ref), v50 (ref), v48 (ref)
        local v696 = v272();
        local v697 = v50.build("Glad to see you again, {name}!", v696, {
            name = v48
        });
        return v50.center(v695, v696, v694.alpha, v697);
    end;
    v50.screen(v693, true);
    v693 = function(v698, _, v700, v701, v702, v703, _, _, v706)
        local v707 = {};
        v707[#v707 + 1] = "{backtrack}t";
        v707[#v707 + 1] = "{hitchance}%";
        v707[#v707 + 1] = "{spread}\194\176";
        if not v698 and v706 > 0 then
            v707[#v707 + 1] = "{health} hp";
        end;
        local v708 = v700 ~= v702;
        local v709 = v701 ~= v703 and not v698;
        if v708 and v709 then
            v707[#v707 + 1] = "{wanted_hitgroup} ({wanted_damage} dmg)";
        else
            if v708 then
                v707[#v707 + 1] = "{wanted_damage} dmg";
            end;
            if v709 then
                v707[#v707 + 1] = "{wanted_hitgroup}";
            end;
        end;
        if #v707 > 0 then
            return " \226\128\186 " .. table.concat(v707, " \194\183 ") .. " \226\128\185";
        else
            return "";
        end;
    end;
    local function v732(v710)
        -- upvalues: v265 (ref), l_v632_0 (ref), l_v631_0 (ref), v272 (ref), v50 (ref), v693 (ref)
        local l_me_1 = v265.me;
        local l_target_0 = v710.target;
        if not l_target_0 or not l_me_1 then
            return;
        else
            local v713 = l_target_0:get_name();
            local v714 = l_target_0:is_alive();
            local v715 = math.floor(v710.hitchance + 0.5);
            local l_damage_0 = v710.damage;
            local v717 = l_v632_0[v710.hitgroup] or "?";
            local l_wanted_damage_0 = v710.wanted_damage;
            local v719 = l_v632_0[v710.wanted_hitgroup] or "?";
            local l_state_0 = v710.state;
            local v721 = l_v631_0[l_state_0] or v272();
            local v722 = ("%.2f"):format(v710.spread or 0);
            local l_backtrack_0 = v710.backtrack;
            local l_m_iHealth_0 = l_target_0.m_iHealth;
            local v725 = "";
            if l_state_0 then
                v725 = v50.build("Miss in {name}'s {wanted_hitgroup} due to {reason}", v721, {
                    name = v713, 
                    reason = l_state_0, 
                    wanted_hitgroup = v719
                });
            elseif v714 then
                v725 = v50.build("Hit {name} in {hitgroup} for {damage} damage", v721, {
                    name = v713, 
                    damage = l_damage_0, 
                    hitgroup = v717
                });
            else
                v725 = v50.build("Killed {name} in {hitgroup}", v721, {
                    name = v713, 
                    hitgroup = v717
                });
            end;
            do
                local l_v725_0 = v725;
                local function v729(v727, v728)
                    -- upvalues: v50 (ref), v721 (ref), l_v725_0 (ref)
                    return v50.center(v728, v721, v727.alpha, l_v725_0);
                end;
                v50.screen(v729);
            end;
            v725 = "";
            local v730 = v693(l_state_0, v715, l_damage_0, v717, l_wanted_damage_0, v719, v722, l_backtrack_0, l_m_iHealth_0);
            local v731 = {
                name = v713, 
                reason = l_state_0, 
                damage = l_damage_0, 
                health = l_m_iHealth_0, 
                spread = v722, 
                hitgroup = v717, 
                hitchance = v715, 
                backtrack = l_backtrack_0, 
                wanted_damage = l_wanted_damage_0, 
                wanted_hitgroup = v719
            };
            if l_state_0 then
                v725 = v50.build("Miss in {name}'s {wanted_hitgroup} due to {reason}" .. v730, v721, v731);
            elseif v714 then
                v725 = v50.build("Hit {name} in {hitgroup} for {damage} damage" .. v730, v721, v731);
            else
                v725 = v50.build("Killed {name} in {hitgroup}" .. v730, v721, v731);
            end;
            v50.print(v725);
            return;
        end;
    end;
    local v733 = {
        [1] = "Suicide is not a solution. Let's talk.", 
        [2] = "Let's talk before it\226\128\153s too late.", 
        [3] = "You're not alone. Let's talk.", 
        [4] = "You matter more than you know.", 
        [5] = "No shame in pain. Just talk.", 
        [6] = "Breathe. Break. Talk. Repeat.", 
        [7] = "Scream, cry, curse \226\128\148 just don't disappear.", 
        [8] = "Death is quiet. Don't be.", 
        [9] = "I'm calling 911."
    };
    local function v744(v734)
        -- upvalues: v265 (ref), l_v631_0 (ref), v272 (ref), v733 (ref), v50 (ref)
        local l_me_2 = v265.me;
        local v736 = entity.get(v734.userid, true);
        local v737 = entity.get(v734.attacker, true);
        if l_me_2 ~= v736 or not v737 then
            return;
        else
            local v738 = v737:get_name();
            local v739 = l_v631_0.death or v272();
            local v740 = "Killed by {name}";
            if l_me_2 == v737 then
                v740 = v733[math.random(1, #v733)] or "Suicide is not a solution. Let's talk.";
            end;
            v740 = v50.build(v740, v739, {
                name = v738
            });
            local function v743(v741, v742)
                -- upvalues: v50 (ref), v739 (ref), v740 (ref)
                return v50.center(v742, v739, v741.alpha, v740);
            end;
            v50.screen(v743);
            v50.print(v740);
            return;
        end;
    end;
    local v745 = {};
    local v746 = nil;
    v746 = function()
        -- upvalues: v745 (ref), l_v626_0 (ref), v265 (ref), v50 (ref), v72 (ref), v746 (ref)
        local v747 = 0;
        for v748, v749 in pairs(v745) do
            if v749.notify then
                if v749.notify.realtime + l_v626_0 < v265.realtime then
                    v50.print(v749.text);
                    v745[v748] = nil;
                end;
                v747 = v747 + 1;
            end;
        end;
        if v747 == 0 then
            v72("render", v746);
        end;
    end;
    local function v760(v750, v751)
        -- upvalues: v745 (ref), v50 (ref), v272 (ref), v265 (ref), v71 (ref), v746 (ref)
        local v752 = v751:get_name();
        local v753 = v751:get_index();
        local v754 = tostring(v753) .. tostring(v752);
        v745[v754] = v745[v754] or {
            damage = 0, 
            text = "", 
            notify = v50.screen(function()

            end)
        };
        if v745[v754].notify == nil then
            return;
        else
            v745[v754].damage = v745[v754].damage + v750.dmg_health;
            local v755 = v272();
            local v756 = v750.health > 0;
            local v757 = v50.build(v756 and "{name} was burned for {damage} hp" or "{name} burned out", v755, {
                name = v752, 
                damage = v745[v754].damage
            });
            if v750.health <= 0 then
                v745[v754].damage = 0;
            end;
            v745[v754].text = v757;
            v745[v754].notify.realtime = v265.realtime;
            v745[v754].notify.callback = function(v758, v759)
                -- upvalues: v50 (ref), v755 (ref), v757 (ref)
                v50.center(v759, v755, v758.alpha, v757);
            end;
            v71("render", v746);
            return;
        end;
    end;
    local function v775(v761)
        -- upvalues: v265 (ref), l_v633_0 (ref), l_v634_0 (ref), v760 (ref), v272 (ref), v50 (ref)
        local l_me_3 = v265.me;
        local v763 = entity.get(v761.userid, true);
        local v764 = entity.get(v761.attacker, true);
        local l_weapon_0 = v761.weapon;
        local v766 = l_v633_0[l_weapon_0];
        local v767 = l_v634_0[l_weapon_0];
        if not v767 or not v766 or not l_me_3 or l_me_3 ~= v764 then
            return;
        elseif l_weapon_0 == "inferno" then
            return v760(v761, v763);
        else
            local v768 = v272();
            local v769 = v763:get_name();
            local l_dmg_health_0 = v761.dmg_health;
            local v771 = "";
            if v761.health > 0 then
                v771 = v50.build(v766 .. " {name} for {damage} damage", v768, {
                    name = v769, 
                    damage = l_dmg_health_0
                });
            else
                v771 = v50.build(v767 .. " {name}", v768, {
                    name = v769
                });
            end;
            local function v774(v772, v773)
                -- upvalues: v50 (ref), v768 (ref), v771 (ref)
                return v50.center(v773, v768, v772.alpha, v771);
            end;
            v50.screen(v774);
            v50.print(v771);
            return;
        end;
    end;
    local function v776()
        -- upvalues: l_v629_0 (ref)
        if l_v629_0 then
            print_raw("");
        end;
    end;
    local function v784(v777)
        -- upvalues: v272 (ref), v50 (ref)
        local v778 = v777.entity:get_name();
        local v779 = v272();
        local v780 = v50.build("Evaded {name}'s shot", v779, {
            name = v778
        });
        local function v783(v781, v782)
            -- upvalues: v50 (ref), v779 (ref), v780 (ref)
            return v50.center(v782, v779, v781.alpha, v780);
        end;
        v50.screen(v783);
        v50.print(v780);
    end;
    local function v785()
        -- upvalues: l_v630_0 (ref), l_v544_1 (ref), l_v627_0 (ref), l_v628_0 (ref), l_v629_0 (ref), v71 (ref), v675 (ref), v732 (ref), v776 (ref), v775 (ref), v744 (ref), v784 (ref), v72 (ref)
        l_v630_0 = l_v544_1:get();
        l_v627_0 = l_v630_0 and l_v544_1.debug:get();
        l_v628_0 = l_v630_0 and l_v544_1.screen:get();
        l_v629_0 = l_v630_0 and l_v544_1.console:get();
        if l_v630_0 and l_v628_0 then
            v71("render", v675);
        end;
        if l_v630_0 and (l_v627_0 or l_v628_0 or l_v629_0) then
            v71("aim_ack", v732);
            v71("round_start", v776);
            v71("player_hurt", v775);
            v71("player_death", v744);
            events.close_shot(v784);
        else
            v72("aim_ack", v732);
            v72("round_start", v776);
            v72("player_hurt", v775);
            v72("player_death", v744);
            events.close_shot(v784, true);
        end;
    end;
    v785();
    l_v544_1:set_callback(v785);
    l_v544_1.debug:set_callback(v785);
    l_v544_1.screen:set_callback(v785);
    l_v544_1.console:set_callback(v785);
end;
v544 = nil;
v545 = v53.features.widgets:switch("\v\f<tarp>    \rWatermark", true, nil, function(v786)
    local v787 = {
        version = v786:switch("\v\f<code>   \rVersion", true), 
        username = v786:switch("\v\f<user>     \rUsername", true)
    };
    v787.username_source = v786:combo("## Username source", {
        [1] = "Cheat", 
        [2] = "Steam", 
        [3] = "Custom"
    }):depend(v787.username);
    v787.username_custom = v786:input("## Username custom"):depend(v787.username, {
        [1] = nil, 
        [2] = "Custom", 
        [1] = v787.username_source
    });
    v787.latency = v786:switch("\v\f<arrows-rotate>     \rLatency", true);
    v787.frames = v786:switch("\v\f<layer-group>     \rFrames", true);
    v787.time = v786:switch("\v\f<clock>     \rTime", true);
    v787.time_format = v786:combo("## Time format", {
        [1] = "24h", 
        [2] = "12h"
    }):depend(v787.time);
    v787.position = v786:combo("\v\f<arrows-up-down-left-right>     \rPosition", {
        [1] = "Top Right", 
        [2] = "Top Left", 
        [3] = "Bottom Center"
    });
    return v787, true;
end);
v51.new("watermark", v545, v70.features.visual);
v623 = v226();
v624 = v226();
v625 = v226();
v626 = panorama.MyPersonaAPI.GetName;
v627 = l_gradient_0.text_animate("\240\157\146\134\240\157\146\151\240\157\146\130\240\157\146\141\240\157\146\130\240\157\146\149\240\157\146\134", -1.3, {
    color()
});
v628 = 0;
v629 = 0;
do
    local l_v545_1, l_v623_1, l_v624_1, l_v625_1, l_v626_1, l_v627_1, l_v628_1, l_v629_1, l_v630_1, l_v631_1 = v545, v623, v624, v625, v626, v627, v628, v629, v630, v631;
    l_v630_1 = function()
        -- upvalues: l_v545_1 (ref), l_RECODE_0 (ref), l_v626_1 (ref), v48 (ref), v265 (ref), l_v629_1 (ref), l_v628_1 (ref)
        local v798 = {};
        if l_v545_1.version.value then
            v798[#v798 + 1] = string.format("\a[accent]\f<code>  \r%s", l_RECODE_0);
        end;
        if l_v545_1.username.value then
            local v799 = l_v545_1.username_source.value == "Steam" and l_v626_1() or l_v545_1.username_source.value == "Custom" and l_v545_1.username_custom.value or v48;
            v798[#v798 + 1] = string.format("\a[accent]\f<user>  \r%s", v799);
        end;
        if l_v545_1.latency.value and v265.net_channel and v265.server_info and v265.server_info.address ~= "loopback" and v265.net_channel.latency then
            v798[#v798 + 1] = string.format("\a[accent]\f<arrows-rotate>  \r%i ms", v265.net_channel.latency[1] * 1000);
        end;
        if l_v545_1.frames.value then
            if v265.realtime > l_v629_1 + 0.8 then
                l_v628_1 = 1 / v265.absoluteframetime;
                l_v629_1 = v265.realtime;
            end;
            v798[#v798 + 1] = string.format("\a[accent]\f<layer-group>  \r%i fps", l_v628_1);
        end;
        if l_v545_1.time.value then
            v798[#v798 + 1] = string.format("\a[accent]\f<clock>  \r%s", common.get_date(l_v545_1.time_format.value == "24h" and "%H:%M" or "%I:%M %p"):lower());
        end;
        return v798;
    end;
    l_v631_1 = nil;
    l_v631_1 = function()
        -- upvalues: l_v545_1 (ref), l_v623_1 (ref), v72 (ref), l_v631_1 (ref), v272 (ref), l_v630_1 (ref), l_pui_0 (ref), v537 (ref), v495 (ref), l_v627_1 (ref), l_v625_1 (ref), l_v624_1 (ref), v455 (ref), v49 (ref)
        local l_value_0 = l_v545_1.value;
        local v801 = l_v623_1(l_value_0);
        if not l_value_0 and v801 <= 0 then
            if not l_v545_1.value then
                v72("render", l_v631_1);
            end;
            return;
        else
            local v802 = v272();
            local v803 = l_v630_1();
            local v804 = l_pui_0.string(table.concat(v803, "   "));
            local v805 = v537(v495.fonts.content, nil, v804);
            l_v627_1:set_colors({
                v802, 
                v802:alpha_modulate(50)
            });
            l_v627_1:animate();
            local v806 = l_v625_1(#v803 > 0);
            local v807 = l_v624_1(v805.x);
            local v808 = l_v627_1:get_animated_text();
            local v809 = v537(v495.fonts.header, nil, v808);
            local v810 = v807 + v809.x + v495.layout.padding.x * v455 * (2 - (1 - v806));
            local v811 = vector(v49.x - v810 - (10 + 5 * v806) * v455, 10 * v801);
            if l_v545_1.position.value == "Top Left" then
                v811 = vector(10, 10 * v801);
            end;
            if l_v545_1.position.value == "Bottom Center" then
                v811 = vector(v49.x / 2 - v810 / 2, v49.y - 44 * v455 * v801);
            end;
            v495.render_rect(v811, v802, v801, v809.x);
            v495.render_text_header(v811 + v495.layout.padding * v455 / 2 - vector(0, 2 * v455), v802:alpha_modulate(255 * v801), nil, v808);
            if v806 > 0 then
                v811.x = v811.x + v809.x + v495.layout.padding.x * v455 + 5 * v455;
                v495.render_rect(v811, v802, v801 * v806, v807);
                v495.render_text_content(v811 + v495.layout.padding * v455 / 2, v495.colors.text.primary:alpha_modulate(255 * v801 * v806), nil, v804);
            end;
            return;
        end;
    end;
    l_v545_1:set_callback(function(v812)
        -- upvalues: v71 (ref), l_v631_1 (ref)
        if v812.value then
            v71("render", l_v631_1);
        end;
    end, true);
end;
v545 = nil;
v623 = v53.features.widgets:switch("\v\f<magnifying-glass>    \rSpectators");
v51.new("specs", v623, v70.features.visual);
v624 = {};
do
    local l_v623_2, l_v624_2, l_v625_2, l_v626_2, l_v627_2, l_v628_2, l_v629_2, l_v630_2, l_v631_2, l_v632_1 = v623, v624, v625, v626, v627, v628, v629, v630, v631, v632;
    l_v625_2 = function()
        -- upvalues: v265 (ref), v230 (ref), l_v624_2 (ref), v226 (ref)
        local v823 = false;
        local v824 = {};
        local l_me_4 = v265.me;
        if not l_me_4 then
            return v823, v824;
        else
            for _, v827 in ipairs(v265.players) do
                local l_entity_0 = v827.entity;
                if v230(l_entity_0) then
                    local v829 = l_entity_0:get_player_info();
                    if v829 then
                        local v830 = l_entity_0:get_name();
                        local v831 = string.format("%s&%s&%s", v830, v829.steamid64, l_entity_0:get_index());
                        l_v624_2[v831] = l_v624_2[v831] or {
                            alpha = 0, 
                            name = v830, 
                            player = l_entity_0, 
                            animate = v226()
                        };
                        l_v624_2[v831].player = l_entity_0;
                        local v832 = l_entity_0.m_hObserverTarget == (v265.is_alive and l_me_4 or l_me_4.m_hObserverTarget);
                        if v832 then
                            v823 = true;
                        end;
                        l_v624_2[v831].alpha = l_v624_2[v831].animate(v832);
                        if l_v624_2[v831].alpha > 0 then
                            table.insert(v824, 1, l_v624_2[v831]);
                        end;
                    end;
                end;
            end;
            return v823, v824;
        end;
    end;
    l_v626_2 = v226();
    l_v627_2 = v226(95, nil, v226.ease_in_out);
    l_v628_2 = 103;
    l_v629_2 = v226();
    l_v630_2 = v538.new("specs", vector(450, 300), vector(100, 44));
    l_v631_2 = render.load_image("\255\216\255\224\000\016JFIF\000\001\001\000\000\001\000\001\000\000\255\254\000;CREATOR: gd-jpeg v1.0 (using IJG JPEG v62), quality = 80\n\255\219\000C\000\006\004\005\006\005\004\006\006\005\006\a\a\006\b\n\016\n\n\t\t\n\020\014\015\f\016\023\020\024\024\023\020\022\022\026\029%\031\026\027#\028\022\022 , #&')*)\025\031-0-(0%()(\255\219\000C\001\a\a\a\n\b\n\019\n\n\019(\026\022\026((((((((((((((((((((((((((((((((((((((((((((((((((\255\192\000\017\b\000\184\000\184\003\001\"\000\002\017\001\003\017\001\255\196\000\031\000\000\001\005\001\001\001\001\001\001\000\000\000\000\000\000\000\000\001\002\003\004\005\006\a\b\t\n\v\255\196\000\181\016\000\002\001\003\003\002\004\003\005\005\004\004\000\000\001}\001\002\003\000\004\017\005\018!1A\006\019Qa\a\"q\0202\129\145\161\b#B\177\193\021R\209\240$3br\130\t\n\022\023\024\025\026%&'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz\131\132\133\134\135\136\137\138\146\147\148\149\150\151\152\153\154\162\163\164\165\166\167\168\169\170\178\179\180\181\182\183\184\185\186\194\195\196\197\198\199\200\201\202\210\211\212\213\214\215\216\217\218\225\226\227\228\229\230\231\232\233\234\241\242\243\244\245\246\247\248\249\250\255\196\000\031\001\000\003\001\001\001\001\001\001\001\001\001\000\000\000\000\000\000\001\002\003\004\005\006\a\b\t\n\v\255\196\000\181\017\000\002\001\002\004\004\003\004\a\005\004\004\000\001\002w\000\001\002\003\017\004\005!1\006\018AQ\aaq\019\"2\129\b\020B\145\161\177\193\t#3R\240\021br\209\n\022$4\225%\241\023\024\025\026&'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz\130\131\132\133\134\135\136\137\138\146\147\148\149\150\151\152\153\154\162\163\164\165\166\167\168\169\170\178\179\180\181\182\183\184\185\186\194\195\196\197\198\199\200\201\202\210\211\212\213\214\215\216\217\218\226\227\228\229\230\231\232\233\234\242\243\244\245\246\247\248\249\250\255\218\000\f\003\001\000\002\017\003\017\000?\000\241]F\246\238\029B\230(ng\1424\149\149Ud \000\t\247\170\223\2187\223\243\251s\255\000\127[\252h\213\191\228+{\255\000]\159\255\000B5V\128-\127h\223\127\207\237\207\253\253o\241\163\251F\251\254\127n\127\239\235\127\141U\162\128-\127h\223\127\207\237\207\253\253o\241\163\251F\251\254\127n\127\239\235\127\141U\162\128-\127h\223\127\207\237\207\253\253o\241\163\251F\251\254\127n\127\239\235\127\141U\162\128-\127h\223\127\207\237\207\253\253o\241\163\251F\251\254\127n\127\239\235\127\141U\162\128-\127h\223\127\207\237\207\253\253o\241\163\251F\251\254\127n\127\239\235\127\141U\162\128-\127h\223\127\207\237\207\253\253o\241\163\251F\251\254\127n\127\239\235\127\141U\162\128-\127h\223\127\207\237\207\253\253o\241\163\251F\251\254\127n\127\239\235\127\141U\162\128-\127h\223\127\207\237\207\253\253o\241\163\251F\251\254\127n\127\239\235\127\141U\162\128-\127h\223\127\207\237\207\253\253o\241\163\251F\251\254\127n\127\239\235\127\141U\162\128-\127h\223\127\207\237\207\253\253o\241\163\251F\251\254\127n\127\239\235\127\141U\162\1284\244\235\219\185\181\vh\166\185\158H\222UVV\144\144A#\222\138\173\164\255\000\200V\203\254\187'\254\132(\160\003V\255\000\144\173\239\253v\127\253\b\213Z\181\171\127\200V\247\254\187?\254\132j\173\000\020QE\000\020QE\000\020QE\000\020QE\000\020QE\000\020QE\000\020QE\000\020QE\000\020QE\000\020QE\000Z\210\127\228+e\255\000]\147\255\000B\020Q\164\255\000\200V\203\254\187'\254\132(\160\003V\255\000\144\173\239\253v\127\253\b\213Z\181\171\127\200V\247\254\187?\254\132j\173\000\020QE\000\020QE\000\020QE\000\020Q[^\020\240\190\175\226\173DYh\150\143;\140\025\028\240\145\015Vn\195\245=\179@\024\180W\210\030\025\248\001\166A\018I\226=Fk\187\140d\197k\136\227\a\184\220Af\250\241]j\252\028\240*\168\aD,GRn\231\201\255\000\199\232\003\228*+\234\rs\224/\134\239#'J\185\189\211\166\199\203\243\t\147\241V\228\254\004W\137\248\247\225\190\187\224\198\243ob\023:q8[\2002S=\131\feO\215\143Bh\003\139\162\138(\000\162\138(\000\162\138(\000\162\138(\002\214\147\255\000![/\250\236\159\250\016\162\141'\254B\182_\245\217?\244!E\000\026\183\252\133o\127\235\179\255\000\232F\170\213\173[\254B\183\191\245\217\255\000\244#Uh\000\162\138(\000\162\138(\000\162\138(\003o\193\158\028\187\241_\136\2374\155\031\149\230l\188\132dD\131\150c\244\253O\021\246W\132\1887\167xWE\135M\210a\t\018\000]\200\027\229|`\179\030\228\227\250\014+\202\255\000f\029\005-\244\029G\\\145?\127w/\217\227'\180h\0018\250\177\255\000\199k\219h\000\162\188S\227\127\197+\191\015\222\157\003\195\142\145\223\132\rsr@c\b#!T\127{\a9#\128x\231\167\128\220x\147\\\184\156\207>\177\168\188\196\231{\\\1859\250\230\128>\233\168\238`\138\234\222K{\152\163\154\tT\171\199\"\130\172\b\193\004w\021\243/\195\015\140z\158\149\127\r\143\138.d\191\210\164!L\242\146\210\192zn-\213\151\212\028\159OC\244\234:\186+\163\006R\003\002\167 \142\185\006\128>K\248\215\240\255\000\254\016\237e.\180\229'E\189c\229\003\146a~\241\147\233\220\019\219\233\154\243j\251K\226\174\130\158\"\240\030\173dWt\201\017\158\003\220H\131r\227\2118#\232k\226\218\000(\162\138\000(\162\138\000(\162\138\000\181\164\255\000\200V\203\254\187'\254\132(\163I\255\000\144\173\151\253vO\253\bQ@\006\173\255\000![\223\250\236\255\000\250\017\170\181kV\255\000\144\173\239\253v\127\253\b\213Z\000(\162\138\000(\162\138\000(\162\138\000\250\227\224=\197\180_\n\180Uy\161G&r\192\176\a>{\245\231\211\021\223}\182\215\254~a\255\000\190\199\248\215\1934P\006\191\140/\155R\241^\177z\237\188\207w+\131\156\140\0228\000\250c\138\200\162\138\000+\237?\1333O?\195\143\015=\206|\207\177\162\228\245*\006\020\254@W\202\031\015\252)w\227\031\018\219\233\150\160\172D\239\184\152\014!\140\017\185\190\189\128\238k\237K\027Xll\173\237-P$\016F\177F\131\162\162\128\000\253(\002VP\202U\128ea\130\015 \138\248\n\190\228\241\174\174\154\023\132\181}I\216)\183\182vRx\203\227\b?\022*+\225\186\000(\162\138\000(\162\138\000(\162\138\000\181\164\255\000\200V\203\254\187'\254\132(\163I\255\000\144\173\151\253vO\253\bQ@\006\173\255\000![\223\250\236\255\000\250\017\170\181kV\255\000\144\173\239\253v\127\253\b\213Z\000(\162\138\000(\162\138\000(\162\138\000(\162\138\000*[[y\174\238\161\183\181\141\229\184\149\196q\198\131%\216\158\000\029\206ME_C\254\206\222\001\242\"_\021\234\208\254\246E\"\1947\028\170\247\151\030\167\160\246\201\238(\003\208\190\020x&\031\005xm p\143\169\220bK\185W\156\1908P\127\186\185\199\191'\189v\180W\154\252m\241\240\240\142\135\246=>O\248\157_!X\177\214\020\232d>\253\135\191=\141\000y\207\237\021\227\164\212\175\a\1344\2017[Z\201\186\238E<<\1638A\236\185\231\223\253\218\241\026Vb\204Y\137fc\146O$\159SI@\005\020Q@\005\020Q@\005\020Q@\022\180\159\249\n\217\127\215d\255\000\208\133\020i?\242\021\178\255\000\174\201\255\000\161\n(\000\213\191\228+{\255\000]\159\255\000B5V\173j\223\242\021\189\255\000\174\207\255\000\161\026\171@\005\020Q@\005\020Q@\005\020Q@\005\020Q@\029\015\195\237\r|I\227M#I\147>M\196\195\205\003\169\141Ag\000\250\237S_m\197\026C\018G\018\004\141\020*\170\140\005\000`\000;\fW\201_\179\216\255\000\139\165\166\255\000\215)\191\244[W\214\244\001\141\227\015\017Y\248W\195\215Z\182\160s\020+\242\16082\185\225T{\147\249\014{W\197\222'\215o|I\174]j\186\148\155\238.\031q\0038A\208*\142\192\014+\221\127j\155\183M/\195\214a\136If\154b\189\137EP\t\255\000\190\205|\237@\005\020Q@\005\020Q@\005\020Q@\005\020Q@\022\180\159\249\n\217\127\215d\255\000\208\133\020i?\242\021\178\255\000\174\201\255\000\161\n(\000\213\191\228+{\255\000]\159\255\000B5V\173j\223\242\021\189\255\000\174\207\255\000\161\026\171@\005\020Q@\005\020Q@\005\020Q@\005\020Q@\029\215\193MZ\199E\248\133c{\170\220\199mh\145\204\026Y8\000\152\200\031\169\175\165\127\225e\2487\254\134\027\031\251\232\255\000\133|aE\000{?\237\027\226m\027\196_\240\143\127bj0\222\249\031h\243|\178N\205\222V\220\241\254\201\175\024\162\138\000(\162\138\000(\162\138\000(\162\138\000(\162\138\000\181\164\255\000\200V\203\254\187'\254\132(\163I\255\000\144\173\151\253vO\253\bQ@\006\173\255\000![\223\250\236\255\000\250\017\170\181kV\255\000\144\173\239\253v\127\253\b\213Z\000(\162\138\000(\162\138\000(\162\138\000(\162\138\000\244?\128pCs\2417O\138\230(\229\140\1991)\"\134\a\247d\142+\234\191\236]+\254\129\150?\248\014\191\225_'\252\f\191\179\211~$X\\\2347v\246\150\203\028\193\165\158A\026\002c \002\196\1289\175\168?\2255\240\183\253\f\186'\254\f\"\255\000\226\168\003\198?j++K?\248F~\201m\f\027\190\213\187\203@\187\191\213c8\028\245\175\b\175o\253\165\245\173+X\255\000\132s\251#S\177\191\242\190\211\230}\150\225e\217\159+\027\182\147\140\224\245\244\175\016\160\002\138(\160\002\138(\160\002\138(\160\002\138(\160\vZO\252\133l\191\235\178\127\232B\1384\159\249\n\217\127\215d\255\000\208\133\020\000j\223\242\021\189\255\000\174\207\255\000\161\026\171V\181o\249\n\222\255\000\215g\255\000\208\141U\160\002\138(\160\002\138(\160\002\138(\160\002\138(\160\002\138(\160\002\138(\160\002\138(\160\002\138(\160\002\138(\160\002\138(\160\vZO\252\133l\191\235\178\127\232B\1384\159\249\n\217\127\215d\255\000\208\133\020\000j\223\242\021\189\255\000\174\207\255\000\161\026\171V\181o\249\n\222\255\000\215g\255\000\208\141U\160\002\138(\160\002\138(\160\002\138(\160\002\138(\160\002\138(\160\002\138(\160\002\138(\160\002\138(\160\002\138(\160\002\138(\160\vZO\252\133l\191\235\178\127\232B\1384\159\249\n\217\127\215d\255\000\208\133\020\001gQ\178\187\155P\185\150\027i\228\141\229fVX\201\004\018}\170\183\246u\247\252\249\\\255\000\223\166\255\000\n(\160\003\251:\251\254|\174\127\239\211\127\133\031\217\215\223\243\229s\255\000~\155\252(\162\128\015\236\235\239\249\242\185\255\000\191M\254\020\127g_\127\207\149\207\253\250o\240\162\138\000?\179\175\191\231\202\231\254\2537\248Q\253\157}\255\000>W?\247\233\191\194\138(\000\254\206\190\255\000\159+\159\251\244\223\225G\246u\247\252\249\\\255\000\223\166\255\000\n(\160\003\251:\251\254|\174\127\239\211\127\133\031\217\215\223\243\229s\255\000~\155\252(\162\128\015\236\235\239\249\242\185\255\000\191M\254\020\127g_\127\207\149\207\253\250o\240\162\138\000?\179\175\191\231\202\231\254\2537\248Q\253\157}\255\000>W?\247\233\191\194\138(\000\254\206\190\255\000\159+\159\251\244\223\225G\246u\247\252\249\\\255\000\223\166\255\000\n(\160\003\251:\251\254|\174\127\239\211\127\133\031\217\215\223\243\229s\255\000~\155\252(\162\128\015\236\235\239\249\242\185\255\000\191M\254\020\127g_\127\207\149\207\253\250o\240\162\138\000\179\167Y]\195\168[K5\180\241\198\146\17134d\000\001\030\212QE\000\127\255\217", vector(30, 30));
    l_v632_1 = nil;
    l_v632_1 = function()
        -- upvalues: l_v625_2 (ref), l_v623_2 (ref), v265 (ref), l_v626_2 (ref), v72 (ref), l_v632_1 (ref), v272 (ref), v455 (ref), l_v630_2 (ref), l_pui_0 (ref), v537 (ref), v495 (ref), l_v628_2 (ref), l_v629_2 (ref), l_v631_2 (ref), l_v627_2 (ref)
        local v833, v834 = l_v625_2();
        local v835 = l_v623_2.value and (v833 or v265.ui_alpha > 0);
        local v836 = l_v626_2(v835);
        if not v835 and v836 <= 0 then
            if not l_v623_2.value then
                v72("render", l_v632_1);
            end;
            return;
        else
            local v837 = v272();
            local v838 = vector() + 4 * v455;
            local v839 = l_v630_2.position + v838;
            local v840 = l_pui_0.string("\a[accent]\f<magnifying-glass>  \rSpectators");
            local v841 = v537(v495.fonts.content, nil, v840);
            local v842 = v495.layout.padding * v455;
            v495.render_rect(v839, v837, v836, l_v628_2);
            v495.render_text_content(v839 + vector(l_v628_2 / 2 - v841.x / 2 + v842.x / 2, v842.y / 2), v495.colors.text.primary:alpha_modulate(255 * v836), nil, v840);
            local v843 = 0;
            local v844 = l_v629_2(v833);
            for _, v846 in ipairs(v834) do
                v843 = v843 + v846.alpha;
            end;
            local v847 = 0;
            local v848 = 0;
            if v844 > 0 then
                v495.render_rect(v839 + vector(0, 30 * v455), v837, v844 * v836, l_v628_2, 16 * v455 * v843);
                for _, v850 in ipairs(v834) do
                    local v851 = v537(v495.fonts.content, nil, v850.name).x + 10 * v455;
                    v495.render_text_content(v839 + vector(v842.x / 2 + 16 * v455, 39 * v455 + 16 * v455 * v847), v495.colors.text.primary:alpha_modulate(255 * v850.alpha * v836), nil, v850.name);
                    local v852 = v850.player:get_steam_avatar();
                    if not v852 or v852.resolution < 1 then
                        v852 = l_v631_2;
                    end;
                    render.texture(v852, v839 + vector(v842.x / 2, 39 * v455 + 16 * v455 * v847), vector() + 12 * v455, color(255, 255 * v850.alpha * v836), 5 * v455);
                    if v848 < v851 and 103 * v455 < v851 then
                        v848 = v851;
                    end;
                    v847 = v847 + v850.alpha;
                end;
            end;
            l_v628_2 = l_v627_2(math.max(v848, 103 * v455));
            l_v630_2:update(v836, vector(l_v628_2 + v842.x + v838.x * 2, 33 * v455));
            return;
        end;
    end;
    l_v623_2:set_callback(function(v853)
        -- upvalues: v71 (ref), l_v632_1 (ref)
        if v853.value then
            v71("render", l_v632_1);
        end;
    end, true);
end;
v623 = nil;
v624 = v53.features.widgets:switch("\v\f<brackets-curly>    \rHotkeys");
v51.new("hotkeys", v624, v70.features.visual);
v625 = {};
v626 = {
    [1] = "hold", 
    [2] = "toggle"
};
v627 = function(v854)
    return v854:gsub("\aDEFAULT", ""):gsub("\a%b{}", ""):gsub("\a%x%x%x%x%x%x%x%x", ""):gsub("[^%w%s]", ""):gsub("^%s+", ""):gsub("%s+$", "");
end;
do
    local l_v624_3, l_v625_3, l_v626_3, l_v627_3, l_v628_3, l_v629_3, l_v630_3, l_v631_3, l_v632_2, l_v633_1, l_v634_1 = v624, v625, v626, v627, v628, v629, v630, v631, v632, v633, v634;
    l_v628_3 = function()
        -- upvalues: v265 (ref), l_v627_3 (ref), l_v626_3 (ref), l_v625_3 (ref), v226 (ref)
        local v866 = false;
        local v867 = {};
        for _, v869 in ipairs(v265.binds) do
            local l_active_0 = v869.active;
            local v871 = l_v627_3(tostring(v869.name));
            local l_value_1 = v869.value;
            if type(l_value_1) == "table" then
                local v873 = {};
                for _, v875 in ipairs(l_value_1) do
                    table.insert(v873, tostring(v875):sub(1, 1));
                end;
                l_value_1 = #v873 <= 0 or table.concat(v873, ", ");
            end;
            if type(l_value_1) == "boolean" then
                l_value_1 = l_v626_3[v869.mode] or "?";
            end;
            if l_active_0 then
                v866 = true;
            end;
            l_v625_3[v871] = l_v625_3[v871] or {
                alpha = 0, 
                name = v871, 
                value = l_value_1, 
                animate = v226()
            };
            if l_v625_3[v871].value ~= l_value_1 then
                l_v625_3[v871].value = l_value_1;
            end;
            l_v625_3[v871].alpha = l_v625_3[v871].animate(l_active_0);
            if l_v625_3[v871].alpha > 0 then
                table.insert(v867, 1, l_v625_3[v871]);
            end;
        end;
        return v866, v867;
    end;
    l_v629_3 = v226();
    l_v630_3 = v226(95, nil, v226.ease_in_out);
    l_v631_3 = 103;
    l_v632_2 = v226();
    l_v633_1 = v538.new("hotkeys", vector(300, 300), vector(100, 44));
    l_v634_1 = nil;
    l_v634_1 = function()
        -- upvalues: l_v628_3 (ref), l_v624_3 (ref), v265 (ref), l_v629_3 (ref), v72 (ref), l_v634_1 (ref), v272 (ref), v455 (ref), l_v633_1 (ref), l_pui_0 (ref), v537 (ref), v495 (ref), l_v631_3 (ref), l_v632_2 (ref), l_v630_3 (ref)
        local v876, v877 = l_v628_3();
        local v878 = l_v624_3.value and (v876 or v265.ui_alpha > 0);
        local v879 = l_v629_3(v878);
        if not v878 and v879 <= 0 then
            if not l_v624_3.value then
                v72("render", l_v634_1);
            end;
            return;
        else
            local v880 = v272();
            local v881 = vector() + 4 * v455;
            local v882 = l_v633_1.position + v881;
            local v883 = l_pui_0.string("\a[accent]\f<brackets-curly>  \rHotkeys");
            local v884 = v537(v495.fonts.content, nil, v883);
            local v885 = v495.layout.padding * v455;
            v495.render_rect(v882, v880, v879, l_v631_3);
            v495.render_text_content(v882 + vector(l_v631_3 / 2 - v884.x / 2 + v885.x / 2, v885.y / 2), v495.colors.text.primary:alpha_modulate(255 * v879), nil, v883);
            local v886 = 0;
            local v887 = l_v632_2(v876);
            for _, v889 in ipairs(v877) do
                v886 = v886 + v889.alpha;
            end;
            local v890 = 0;
            local v891 = 0;
            if v887 > 0 then
                v495.render_rect(v882 + vector(0, 30 * v455), v880, v887 * v879, l_v631_3, 16 * v455 * v886);
                for _, v893 in ipairs(v877) do
                    local v894 = v537(v495.fonts.content, nil, v893.name);
                    local v895 = v537(v495.fonts.content, nil, v893.value);
                    local v896 = v894.x + v895.x + 10 * v455;
                    v495.render_text_content(v882 + vector(v885.x / 2, 39 * v455 + 16 * v455 * v890), v495.colors.text.primary:alpha_modulate(255 * v893.alpha * v879), nil, v893.name);
                    v495.render_text_content(v882 + vector(l_v631_3 + v885.x / 2 - v895.x, 39 * v455 + 16 * v455 * v890), v495.colors.text.primary:alpha_modulate(150 * v893.alpha * v879), nil, v893.value);
                    if v891 < v896 and 103 * v455 < v896 then
                        v891 = v896;
                    end;
                    v890 = v890 + v893.alpha;
                end;
            end;
            l_v631_3 = l_v630_3(math.max(v891, 103 * v455));
            l_v633_1:update(v879, vector(l_v631_3 + v885.x + v881.x * 2, 33 * v455));
            return;
        end;
    end;
    l_v624_3:set_callback(function(v897)
        -- upvalues: v71 (ref), l_v634_1 (ref)
        if v897.value then
            v71("render", l_v634_1);
        end;
    end, true);
end;
v624 = nil;
v625 = v53.features.crosshair:switch("\v\f<triangle>     \rCrosshair");
v51.new("crosshair_indicators", v625, v70.features.visual);
v626 = vector(55, 18);
v627 = v538.new_offset("crosshair", vector(v49.x / 2, v49.y / 2), v626, 10, 100, false);
v628 = {};
do
    local l_v625_4, l_v626_4, l_v627_4, l_v628_4, l_v630_4, l_v631_4 = v625, v626, v627, v628, v630, v631;
    v629 = function(v904, v905)
        -- upvalues: l_v628_4 (ref), v226 (ref)
        l_v628_4[v904] = {
            off = 0, 
            data = {}, 
            offset = v905 or 0, 
            create = function(v906, v907)
                -- upvalues: v226 (ref)
                table.insert(v906.data, setmetatable(v907, {
                    __index = {
                        alpha = 0, 
                        anim_alpha = v226(), 
                        get = function(_)
                            return true;
                        end, 
                        paint = function(_)

                        end
                    }
                }));
            end
        };
        return l_v628_4[v904];
    end;
    l_v630_4 = v226();
    l_v631_4 = nil;
    l_v631_4 = function()
        -- upvalues: l_v625_4 (ref), v265 (ref), l_v630_4 (ref), v72 (ref), l_v631_4 (ref), l_v627_4 (ref), v455 (ref), l_v628_4 (ref), l_v626_4 (ref)
        local v910 = l_v625_4.value and (v265.is_alive or v265.ui_alpha > 0);
        local v911 = l_v630_4(v910);
        if not v910 and v911 <= 0 then
            if not l_v625_4.value then
                v72("render", l_v631_4);
            end;
            return;
        else
            local v912 = 1;
            local v913 = vector(l_v627_4.position.x + 5 * v455 * v265.anim_scoped, l_v627_4.position.y + l_v627_4.offset);
            for v914, v915 in pairs(l_v628_4) do
                local v916 = 0;
                for _, v918 in ipairs(v915.data) do
                    local v919 = v918:get() and v912 == v914;
                    v918.alpha = v918.anim_alpha(v919) * v911;
                    if v918.alpha > 0 then
                        v918:paint(vector(v913.x, v913.y + v915.offset * v455 * v916), v265.anim_scoped);
                    end;
                    v916 = v916 + v918.alpha;
                end;
            end;
            l_v627_4:update(v911, l_v626_4 * v455, 5);
            return;
        end;
    end;
    l_v625_4:set_callback(function(v920)
        -- upvalues: v71 (ref), l_v631_4 (ref)
        if v920.value then
            v71("render", l_v631_4);
        end;
    end, true);
    v633 = v629(1, 10);
    v633:create({
        header_text = l_gradient_0.text_animate("\240\157\146\134\240\157\146\151\240\157\146\130\240\157\146\141\240\157\146\130\240\157\146\149\240\157\146\134", -1, {
            v272()
        }), 
        paint = function(v921, v922, v923)
            -- upvalues: v272 (ref), v537 (ref), v495 (ref), v455 (ref)
            local v924 = v272():alpha_modulate(255 * v921.alpha);
            v921.header_text:set_colors({
                v924, 
                v924:alpha_modulate(50)
            });
            v921.header_text:animate();
            local v925 = v921.header_text:get_animated_text();
            local v926 = v537(v495.fonts.header, "", v925);
            v922.x = v922.x - v926.x / 2 * (1 - v923);
            local v927 = vector(v922.x, v922.y + 10 * v455);
            render.shadow(v927, v927 + vector(v926.x, 0), v924, 40 * v455);
            v495.render_text_header(v922, v924, nil, v925);
            local v928 = rage.antiaim:get_max_desync();
            local v929 = math.min(math.abs(math.normalize_yaw(rage.antiaim:get_rotation(true) - rage.antiaim:get_rotation())), v928) / v928;
            if v929 < 0.9 then
                return;
            else
                v922.y = v922.y + 13 * v455;
                local v930 = 1 * v455;
                local v931 = v924:alpha_modulate(0);
                local v932 = v926.x / 2;
                render.gradient(v922 + vector(v932, 0), v922 + vector(v932, 0) - vector(v932 * v929, -v930), v924, v931, v924, v931);
                render.gradient(v922 + vector(v932, 0), v922 + vector(v932, 0) + vector(v932 * v929, v930), v924, v931, v924, v931);
                return;
            end;
        end
    });
    v633:create({
        get = function(_)
            -- upvalues: v265 (ref)
            return v265.is_double_tap;
        end, 
        paint = function(v934, v935, v936)
            -- upvalues: v52 (ref), v537 (ref), v455 (ref), v265 (ref)
            local v937 = v52.double_tap:get_override();
            local v938 = v937 ~= nil and v937 == false and 100 or 255;
            local v939 = color():alpha_modulate(v938 * v934.alpha);
            local v940 = color(0):alpha_modulate(50 * v934.alpha);
            local v941 = "DT";
            local v942 = v537(2, "", v941);
            v935.x = v935.x - v942.x / 2 * (1 - v936) - 4 * v455 * (1 - v936);
            v935.y = v935.y + 5 * v455;
            render.text(2, v935, v939, nil, v941);
            render.circle_outline(v935 + vector(15, 6) * v455, v940, 3.4 * v455, 0, 1, v455);
            render.circle_outline(v935 + vector(15, 6) * v455, v939, 3.4 * v455, 0, v265.exploit_charge, v455);
        end
    });
    v633:create({
        get = function(_)
            -- upvalues: v52 (ref), v265 (ref)
            return v52.hide_shots:get_override() or v265.is_hide_shots;
        end, 
        paint = function(v944, v945, v946)
            -- upvalues: v265 (ref), v52 (ref), v537 (ref), v455 (ref)
            local v947 = v265.is_double_tap and v52.double_tap:get_override() == nil and 100 or 255;
            local v948 = color():alpha_modulate(v947 * v944.alpha);
            local v949 = "HS";
            local v950 = v537(2, "", v949);
            v945.x = v945.x - v950.x / 2 * (1 - v946);
            v945.y = v945.y + 5 * v455;
            render.text(2, v945, v948, nil, v949);
        end
    });
    v633:create({
        get = function(_)
            -- upvalues: v265 (ref)
            return v265.is_min_damage;
        end, 
        paint = function(v952, v953, v954)
            -- upvalues: v537 (ref), v455 (ref)
            local v955 = color():alpha_modulate(255 * v952.alpha);
            local v956 = "DMG";
            local v957 = v537(2, "", v956);
            v953.x = v953.x - v957.x / 2 * (1 - v954);
            v953.y = v953.y + 5 * v455;
            render.text(2, v953, v955, nil, v956);
        end
    });
end;
v625 = nil;
v626 = v53.features.crosshair:switch("\v\f<hundred-points>     \rDamage", false, nil, function(v958)
    -- upvalues: v51 (ref)
    local v959 = {
        font = v958:list("\v\f<font>    \rFont", {
            [1] = "Base", 
            [2] = "Pixel", 
            [3] = "Custom"
        }), 
        animate = v958:switch("\v\f<wave-sine>    \rAnimate", true), 
        always_on = v958:switch(" \v\f<power-off>    \rAlways on", true)
    };
    v51.set_callback_list(v959.font, true);
    return v959, true;
end);
v51.new("damage_indicator", v626, v70.features.visual);
v627 = v538.new("damage", vector(v49.x / 2 + 1, v49.y / 2 - 17), vector(25, 14));
v628 = v226();
v629 = v226(0, 0.1, v226.ease_in_out);
v630 = render.load_font("arial", vector(11, 9), "a");
v631 = nil;
do
    local l_v626_5, l_v627_5, l_v628_5, l_v629_4, l_v630_5, l_v631_5 = v626, v627, v628, v629, v630, v631;
    l_v631_5 = function()
        -- upvalues: l_v626_5 (ref), v265 (ref), l_v628_5 (ref), v72 (ref), l_v631_5 (ref), l_v627_5 (ref), v49 (ref), v455 (ref), v52 (ref), l_v629_4 (ref), v537 (ref), l_v630_5 (ref)
        local v966 = l_v626_5.value and (v265.is_alive or v265.ui_alpha > 0);
        local v967 = l_v628_5(v966);
        if not v966 and v967 <= 0 then
            if not l_v626_5.value then
                v72("render", l_v631_5);
            end;
            return;
        else
            l_v627_5:set_limit(vector(v49.x / 2 - 50, v49.y / 2 - 50), vector(100, 100));
            local v968 = vector();
            local v969 = vector(7, 5) * v455;
            local v970 = v52.damage:get();
            local v971 = math.floor(l_v629_4(v970));
            local v972 = l_v626_5.animate.value and v971 or v970;
            local v973 = tostring(v972 == 0 and "A" or v972);
            local v974 = color():alpha_modulate((v265.is_min_damage and 255 or 50 * (l_v626_5.always_on.value and 1 or v265.ui_alpha)) * v967);
            local l_value_2 = l_v626_5.font.value;
            if l_value_2 == 1 then
                v968 = v537(1, "", v973);
                render.text(1, l_v627_5.position + v969 / 2, v974, nil, v973);
            end;
            if l_value_2 == 2 then
                v968 = v537(2, "", v973);
                render.text(2, l_v627_5.position + v969 / 2, v974, nil, v973);
            end;
            if l_value_2 == 3 then
                v968 = v537(l_v630_5, "", v973);
                render.text(l_v630_5, l_v627_5.position + v969 / 2, v974, nil, v973);
            end;
            l_v627_5:update(v967, v968 + v969, 5);
            return;
        end;
    end;
    l_v626_5:set_callback(function(v976)
        -- upvalues: v71 (ref), l_v631_5 (ref)
        if v976.value then
            v71("render", l_v631_5);
        end;
    end, true);
end;
v626 = nil;
v627 = nil;
v628 = v53.features.crosshair:switch("\v\f<angle>      \rArrows", false, nil, function(v977)
    -- upvalues: v51 (ref)
    local v978 = {
        style = v977:list("\v\f<palette>   \rStyle", {
            [1] = "\f<location-arrow>    \rPrimed", 
            [2] = "\f<angles-right>    \rDelicate"
        }), 
        always_on = v977:switch(" \v\f<power-off>    \rAlways on", true)
    };
    v51.set_callback_list(v978.style);
    return v978, true;
end);
v51.new("arrows", v628, v70.features.visual);
v629 = v538.new_offset("arrows", vector(v49.x / 2, v49.y / 2), vector(15, 15), 30, 100, true, true);
v630 = {
    primed = {
        left = render.load_image("<svg width=\"39\" height=\"45\" viewBox=\"0 0 39 45\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M34.41 1.07819C36.8485 -0.329653 39.7081 2.09415 38.7188 4.73032L32.3794 21.6229C32.1244 22.3024 32.1244 23.0514 32.3794 23.731L38.7188 40.6235C39.7081 43.2597 36.8485 45.6835 34.41 44.2756L1.49996 25.275C-0.500042 24.1203 -0.500043 21.2335 1.49996 20.0788L34.41 1.07819Z\" fill=\"white\"/> </svg>", vector() + 10), 
        right = render.load_image("<svg width=\"39\" height=\"45\" viewBox=\"0 0 39 45\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"> <path d=\"M4.58032 44.3833C2.14187 45.7912 -0.717708 43.3674 0.271586 40.7312L6.61098 23.8387C6.866 23.1591 6.866 22.4101 6.61098 21.7306L0.271582 4.83803C-0.717712 2.20186 2.14186 -0.221952 4.58031 1.18589L37.4904 20.1865C39.4904 21.3412 39.4904 24.228 37.4904 25.3827L4.58032 44.3833Z\" fill=\"white\"/> </svg>", vector() + 10)
    }, 
    delicate = {
        left = render.load_image("<svg width=\"5\" height=\"10\" viewBox=\"0 0 5 10\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M5 0L2 0L0 4.5L0 5.5L2 10H5L3 5.5L3 5L3 4.5L5 0Z\" fill=\"white\"/></svg>", vector(5, 10)), 
        right = render.load_image("<svg width=\"5\" height=\"10\" viewBox=\"0 0 5 10\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M0 10L3 10L5 5.5L5 4.5L3 -1.74846e-07L8.74228e-07 -4.37114e-07L2 4.5L2 5L2 5.5L0 10Z\" fill=\"white\"/></svg>", vector(5, 10))
    }
};
v631 = v226();
v632 = nil;
do
    local l_v628_6, l_v629_5, l_v630_6, l_v631_6, l_v632_3 = v628, v629, v630, v631, v632;
    l_v632_3 = function()
        -- upvalues: l_v628_6 (ref), v265 (ref), l_v631_6 (ref), v72 (ref), l_v632_3 (ref), l_v629_5 (ref), v455 (ref), v272 (ref), v626 (ref), l_v630_6 (ref)
        local v984 = l_v628_6.value and (v265.is_alive or v265.ui_alpha > 0);
        local v985 = l_v631_6(v984);
        if not v984 and v985 <= 0 then
            if not l_v628_6.value then
                v72("render", l_v632_3);
            end;
            return;
        else
            l_v629_5:update(v985, vector() + 15 * v455, 4);
            local v986 = v272():alpha_modulate(255 * v985);
            local l_value_3 = l_v628_6.style.value;
            local l_offset_0 = l_v629_5.offset;
            local v989 = l_v629_5.position - vector(0, 12 * v455 * v265.anim_scoped);
            local v990 = v626 and v626.value;
            local v991 = v990 == "Left";
            local v992 = v990 == "Right";
            local v993 = color(0, 75 * (l_v628_6.always_on.value and 1 or v265.ui_alpha) * v985);
            local v994 = v991 and v986 or v993;
            local v995 = v992 and v986 or v993;
            if l_value_3 == 1 then
                local v996 = vector() + 10 * v455;
                render.texture(l_v630_6.primed.left, vector(v989.x - l_offset_0 - 5 * v455, v989.y - 5 * v455), v996, v994);
                render.texture(l_v630_6.primed.right, vector(v989.x + l_offset_0 - 5 * v455, v989.y - 5 * v455), v996, v995);
            end;
            if l_value_3 == 2 then
                local v997 = vector(5, 10) * v455;
                render.texture(l_v630_6.delicate.left, vector(v989.x - l_offset_0 - 2.5 * v455, v989.y - 5 * v455), v997, v994);
                render.texture(l_v630_6.delicate.right, vector(v989.x + l_offset_0 - 2.5 * v455, v989.y - 5 * v455), v997, v995);
            end;
            return;
        end;
    end;
    l_v628_6:set_callback(function(v998)
        -- upvalues: v71 (ref), l_v632_3 (ref)
        if v998.value then
            v71("render", l_v632_3);
        end;
    end, true);
end;
v628 = nil;
v629 = v53.features.crosshair:switch("\v\f<scribble>     \rScope", false, nil, function(v999)
    local v1000 = {
        gap = v999:slider("\v\f<circle-arrow-up-right>    \rGap", 0, 100, 5, 1, "px"), 
        length = v999:slider("\v\f<ruler>    \rLength", 0, 300, 55, 1, "px"), 
        invert = v999:switch("\v\f<arrow-up-arrow-down>     \rInvert"), 
        custom_color = v999:switch("\v\f<palette>    \rCustom color", false, "Enable to use custom color instead of accent color", color(255, 121))
    };
    v1000.custom_color.color:depend(v1000.custom_color);
    return v1000, true;
end);
v51.new("scope_lines", v629, v70.features.visual);
v630 = v226(nil, 0.15, v226.ease_in_out);
v631 = v226(nil, 0.3, v226.ease_in_out);
v632 = nil;
do
    local l_v629_6, l_v630_7, l_v631_7, l_v632_4 = v629, v630, v631, v632;
    l_v632_4 = function()
        -- upvalues: l_v629_6 (ref), v265 (ref), v35 (ref), l_v630_7 (ref), v52 (ref), v72 (ref), l_v632_4 (ref), v49 (ref), v455 (ref), v272 (ref), l_v631_7 (ref)
        local v1005 = l_v629_6.value and v265.is_scoped;
        local v1006 = v35(l_v630_7(v1005 and 1.1 or 0), 0, 1);
        if not v1005 and v1006 <= 0 then
            if not l_v629_6.value then
                v52.scope_overlay:override();
                v72("render", l_v632_4);
            end;
            return;
        else
            v52.scope_overlay:override("Remove All");
            local v1007 = v49 / 2;
            local v1008 = l_v629_6.gap.value * v1006;
            local v1009 = l_v629_6.length.value * v1006;
            local v1010 = math.max(v455, 1);
            local v1011 = v272();
            if l_v629_6.custom_color.value then
                v1011 = l_v629_6.custom_color.color.value;
            end;
            local v1012 = l_v631_7(l_v629_6.invert.value);
            local v1013 = v1011.alpha_modulate(v1011, v1011.a * v1006 * (1 - v1012));
            local v1014 = v1011.alpha_modulate(v1011, v1011.a * v1006 * v1012);
            render.gradient(vector(v1007.x - v1008 + v1010, v1007.y), vector(v1007.x - v1008 - v1009 + v1010, v1007.y + v1010), v1013, v1014, v1013, v1014);
            render.gradient(vector(v1007.x + v1008, v1007.y), vector(v1007.x + v1008 + v1009, v1007.y + v1010), v1013, v1014, v1013, v1014);
            render.gradient(vector(v1007.x, v1007.y + v1008), vector(v1007.x + v1010, v1007.y + v1008 + v1009), v1013, v1013, v1014, v1014);
            render.gradient(vector(v1007.x, v1007.y - v1008 + v1010), vector(v1007.x + v1010, v1007.y - v1008 - v1009 + v1010), v1013, v1013, v1014, v1014);
            return;
        end;
    end;
    l_v629_6:set_callback(function(v1015)
        -- upvalues: v71 (ref), l_v632_4 (ref)
        if v1015.value then
            v71("render", l_v632_4);
        end;
    end, true);
end;
v629 = {};
v630 = {};
v631 = 0;
v632 = v226();
v633 = v226();
v634 = v538.new_offset("stack", vector(v49.x / 2, 0), vector(100, 44), v49.y / 3, v49.y, false);
do
    local l_v630_8, l_v631_8, l_v632_5, l_v633_2, l_v634_2 = v630, v631, v632, v633, v634;
    local function v1023()
        -- upvalues: l_v630_8 (ref)
        for _, v1022 in ipairs(l_v630_8) do
            if v1022.element:get() then
                return true;
            end;
        end;
        return false;
    end;
    local v1024 = nil;
    v1024 = function()
        -- upvalues: v1023 (ref), v265 (ref), l_v632_5 (ref), v72 (ref), v1024 (ref), l_v631_8 (ref), l_v634_2 (ref), v455 (ref), l_v630_8 (ref), l_v633_2 (ref)
        local v1025 = v1023();
        local v1026 = v1025 and (v265.is_alive or v265.ui_alpha > 0);
        local v1027 = l_v632_5(v1026);
        if v1027 <= 0 then
            if not v1025 then
                v72("render", v1024);
            end;
            return;
        else
            l_v631_8 = 0;
            local v1028 = 0;
            local v1029 = l_v634_2.position + vector(0, l_v634_2.offset) + vector(0, 4) * v455;
            for _, v1031 in ipairs(l_v630_8) do
                v1031:paint(v1029, v1028, v1027);
                v1031.alpha = v1031.alpha * v1027;
                if v1031.alpha > 0 and v1031.width > l_v631_8 then
                    l_v631_8 = v1031.width;
                end;
                v1028 = v1028 + v1031.alpha;
            end;
            local v1032 = l_v633_2(l_v631_8 + 8 * v455);
            l_v634_2:update(v1027, vector(v1032, 33 * v455 * v1028), 16);
            return;
        end;
    end;
    local function v1034(v1033)
        -- upvalues: v71 (ref), v1024 (ref)
        if v1033.value then
            v71("render", v1024);
        end;
    end;
    v629.create = function(_, v1036, v1037, v1038)
        -- upvalues: v226 (ref), v1034 (ref), l_v630_8 (ref)
        local v1042 = {
            alpha = 0, 
            width = 0, 
            anim_alpha = v226(), 
            name = v1036, 
            element = v1037, 
            paint = function(_, _, _)

            end
        };
        v1037:set_callback(v1034, true);
        l_v630_8[#l_v630_8 + 1] = setmetatable(v1038, {
            __index = v1042
        });
    end;
end;
v630 = nil;
v631 = v53.features.stack:switch("\v\f<person-running>     \rSlow down");
v51.new("slow_down", v631, v70.features.visual);
v632 = {
    person = l_pui_0.string("\f<person>"), 
    person_running = l_pui_0.string("\f<person-running>")
};
v633 = {
    white = color(), 
    red = color(255, 0, 0), 
    yellow = color(213, 197, 84)
};
do
    local l_v631_9, l_v632_6, l_v633_3 = v631, v632, v633;
    v629:create("slow_down", l_v631_9, {
        anim_velocity_modifier = v226(), 
        paint = function(v1046, v1047, v1048, _)
            -- upvalues: v265 (ref), v455 (ref), v230 (ref), l_v631_9 (ref), l_v633_3 (ref), v495 (ref), l_v632_6 (ref)
            local l_me_5 = v265.me;
            local v1051 = 110 * v455;
            local v1052 = v1046.anim_velocity_modifier(l_me_5 and v230(l_me_5) and l_me_5.m_flVelocityModifier or 0);
            v1046.alpha = v1046.anim_alpha(l_v631_9.value and (v1052 < 1 or v265.ui_alpha > 0));
            if v1046.alpha <= 0 then
                return;
            else
                local v1053 = (v1052 >= 0.7 and l_v633_3.white:lerp(l_v633_3.yellow, (1 - v1052) / 0.3) or l_v633_3.yellow:lerp(l_v633_3.red, (0.7 - v1052) / 0.7)):alpha_modulate(255 * v1046.alpha);
                local v1054 = v495.layout.padding * v455;
                local v1055 = v1047 - vector(v1054.x / 2 + v1051 / 2, 0) + vector(0, 32 * v455 * v1048);
                v495.render_rect(v1055, v1053, v1046.alpha, v1051);
                v495.render_text_content(v1055 + v1054 / 2, v1053, nil, l_v632_6.person_running);
                v495.render_text_content(v1055 + vector(v1051 + v1054.x / 2, v1054.y / 2), v1053, "r", l_v632_6.person);
                local v1056 = v1051 - 23 * v455;
                local v1057 = v1056 * (1 - v1052);
                local v1058 = v1055 + vector(25, 11) * v455;
                render.rect(v1058, v1058 + vector(v1056, 3), color(255, 30 * v1046.alpha), 4 * v455);
                if v1057 > 0 then
                    render.rect(v1058, v1058 + vector(v1057, 3 * v455), v1053, 4 * v455);
                end;
                v1046.width = v1051 + v1054.x;
                return;
            end;
        end
    });
end;
v631 = nil;
v632 = v53.features.stack:switch("\v\f<snowflake>    \rFake lag", false, nil, function(v1059)
    -- upvalues: v51 (ref)
    local v1060 = {
        style = v1059:list("\v\f<palette>   \rStyle", {
            [1] = "\f<bars-filter>     Lines", 
            [2] = "\f<circle-o>    Circle"
        })
    };
    v51.set_callback_list(v1060.style);
    return v1060, true;
end);
v51.new("fl_indicator", v632, v70.features.visual);
v633 = 2.5;
v634 = 0;
local v1061 = 0;
local v1062 = {};
do
    local l_v632_7, l_v633_4, l_v634_3, l_v1061_0, l_v1062_0 = v632, v633, v634, v1061, v1062;
    l_v632_7:set_event("createmove", function(v1068)
        -- upvalues: l_v1061_0 (ref), l_v634_3 (ref), v265 (ref), l_v1062_0 (ref)
        l_v1061_0 = v1068.choked_commands;
        if l_v1061_0 > 3 then
            l_v634_3 = v265.realtime;
        end;
        table.insert(l_v1062_0, v1068.choked_commands);
        if #l_v1062_0 > 14 then
            table.remove(l_v1062_0, 1);
        end;
    end);
    v629:create("FL", l_v632_7, {
        anim_velocity_modifier = v226(), 
        paint = function(v1069, v1070, v1071, _)
            -- upvalues: l_v632_7 (ref), l_v634_3 (ref), l_v633_4 (ref), v265 (ref), v272 (ref), l_pui_0 (ref), v537 (ref), v495 (ref), v455 (ref), l_v1062_0 (ref), l_v1061_0 (ref)
            v1069.alpha = v1069.anim_alpha(l_v632_7.value and (l_v634_3 + l_v633_4 > v265.realtime or v265.ui_alpha > 0));
            if v1069.alpha <= 0 then
                return;
            else
                local v1073 = v272():alpha_modulate(255 * v1069.alpha);
                local l_value_4 = l_v632_7.style.value;
                local v1075 = l_pui_0.string("\a[accent]\f<snowflake>  \rFL");
                local v1076 = v537(v495.fonts.content, nil, v1075);
                local v1077 = v495.layout.padding * v455;
                local v1078 = v1076.x + (l_value_4 == 1 and 35 or 20) * v455;
                local v1079 = v1070 - vector(v1077.x / 2 + v1078 / 2, 0) + vector(0, 32 * v455 * v1071);
                v495.render_rect(v1079, v1073, v1069.alpha, v1078);
                v495.render_text_content(v1079 + v1077 / 2, color(255, 255 * v1069.alpha), nil, v1075);
                if l_value_4 == 1 then
                    for v1080, v1081 in ipairs(l_v1062_0) do
                        local v1082 = 8 * (v1081 / 14) * v455;
                        local v1083 = v1079 + v1077 / 2 + vector(1 + 2 * v1080, 0) * v455 - vector(0, v1082 / 2) + vector(v1076.x + 5 * v455, 6 * v455);
                        local v1084 = vector(1, v1082);
                        render.rect(v1083, v1083 + v1084, v1073);
                    end;
                end;
                if l_value_4 == 2 then
                    local v1085 = v1079 + v1077 / 2 + vector(v1076.x + 14 * v455, 6 * v455);
                    local v1086 = 9 * (l_v1061_0 / 14) * v455;
                    render.circle(v1085, v1073, 2, 0, 1);
                    render.circle_outline(v1085, v1073, v1086, 0, 1, 1);
                end;
                v1069.width = v1078 + v1077.x;
                return;
            end;
        end
    });
end;
v632 = nil;
v633 = v53.features.stack:switch("\v\f<wind>    \rExploit");
v51.new("exp_indicator", v633, v70.features.visual);
do
    local l_v633_5 = v633;
    v629:create("EXP", l_v633_5, {
        anim_is_defensive = v226(0, 0.12, v226.ease_in_out), 
        paint = function(v1088, v1089, v1090, _)
            -- upvalues: v265 (ref), l_v633_5 (ref), v272 (ref), l_pui_0 (ref), v537 (ref), v495 (ref), v455 (ref)
            local v1092 = v265.is_double_tap or v265.is_hide_shots;
            v1088.alpha = v1088.anim_alpha(l_v633_5.value and (v1092 or v265.ui_alpha > 0));
            if v1088.alpha <= 0 then
                return;
            else
                local v1093 = v1088.anim_is_defensive(not v265.is_defensive);
                local v1094 = v272():alpha_modulate(255 * v1088.alpha);
                local v1095 = l_pui_0.string("\a[accent]\f<wind>  \rEX");
                local v1096 = v537(v495.fonts.content, nil, v1095);
                local v1097 = v1096.x + 15 * v455;
                local v1098 = v495.layout.padding * v455;
                local v1099 = v1089 - vector(v1098.x / 2 + v1097 / 2, 0) + vector(0, 32 * v455 * v1090);
                v495.render_rect(v1099, v1094, v1088.alpha, v1097);
                v495.render_text_content(v1099 + v1098 / 2, color(255, 255 * v1088.alpha), nil, v1095);
                local v1100 = v1099 + v1098 / 2 + vector(v1096.x + 11 * v455, 6 * v455);
                render.circle_outline(v1100, color(0, 25 * v1088.alpha), 6 * v455, 0, 1, 2 * v455);
                render.circle_outline(v1100, v1094, 6 * v455, 0, v265.exploit_charge * v1093, 2 * v455);
                v1088.width = v1097 + v1098.x;
                return;
            end;
        end
    });
end;
v633 = nil;
v634 = {
    [1] = "fov", 
    [2] = "offset_x", 
    [3] = "offset_y", 
    [4] = "offset_z"
};
do
    local l_v634_4, l_v1061_1, l_v1062_1 = v634, v1061, v1062;
    l_v1061_1 = v53.features.world:switch("\v\f<hand>     \rViewmodel", false, nil, function(v1104)
        -- upvalues: l_v634_4 (ref)
        local v1105 = {
            fov = v1104:slider("## fov", 0, 1500, 680, 0.1), 
            offset_x = v1104:slider("## x", -100, 100, 25, 0.1), 
            offset_y = v1104:slider("## y", -100, 100, 0, 0.1), 
            offset_z = v1104:slider("## z", -100, 100, -20, 0.1), 
            opposite_knife = v1104:switch("\v\f<sword>    \rOpposite knife")
        };
        v1104:label("\v\f<rotate-right>    \rReset");
        v1105.reset = v1104:button("   \v\f<rotate-right>   ", nil, true);
        local function v1108()
            -- upvalues: l_v634_4 (ref), v1105 (ref)
            for _, v1107 in ipairs(l_v634_4) do
                v1105[v1107]:reset();
            end;
        end;
        v1105.reset:set_callback(v1108);
        return v1105, true;
    end);
    v51.new("viewmodel", l_v1061_1, v70.features.visual);
    l_v1062_1 = {
        fov = cvar.viewmodel_fov, 
        offset_x = cvar.viewmodel_offset_x, 
        offset_y = cvar.viewmodel_offset_y, 
        offset_z = cvar.viewmodel_offset_z, 
        cl_righthand = cvar.cl_righthand
    };
    local v1109 = {
        fov = l_v1062_1.fov:float(), 
        offset_x = l_v1062_1.offset_x:float(), 
        offset_y = l_v1062_1.offset_y:float(), 
        offset_z = l_v1062_1.offset_z:float(), 
        righthand = l_v1062_1.cl_righthand:int()
    };
    local function v1110()
        -- upvalues: l_v1062_1 (ref), v1109 (ref)
        l_v1062_1.fov:float(v1109.fov, true);
        l_v1062_1.offset_x:float(v1109.offset_x, true);
        l_v1062_1.offset_y:float(v1109.offset_y, true);
        l_v1062_1.offset_z:float(v1109.offset_z, true);
        l_v1062_1.cl_righthand:int(v1109.righthand, true);
    end;
    local v1111 = {
        fov = v1109.fov, 
        offset_x = v1109.offset_x, 
        offset_y = v1109.offset_y, 
        offset_z = v1109.offset_z
    };
    local v1112 = nil;
    v1112 = function()
        -- upvalues: l_v1061_1 (ref), l_v634_4 (ref), v1109 (ref), v1111 (ref), v536 (ref), l_v1062_1 (ref), v1110 (ref), v72 (ref), v1112 (ref)
        local l_value_5 = l_v1061_1.value;
        local v1114 = 0;
        for _, v1116 in ipairs(l_v634_4) do
            local v1117 = l_value_5 and l_v1061_1[v1116].value * 0.1 or v1109[v1116];
            v1111[v1116] = v536(v1111[v1116], v1117, 10);
            if v1117 == v1111[v1116] and v1111[v1116] == l_v1062_1[v1116]:float() then
                v1114 = v1114 + 1;
            else
                l_v1062_1[v1116]:float(v1111[v1116], true);
            end;
        end;
        if #l_v634_4 <= v1114 then
            if not l_value_5 then
                v1110();
            end;
            v72("render", v1112);
        end;
    end;
    local function v1118()
        -- upvalues: v71 (ref), v1112 (ref)
        v71("render", v1112);
    end;
    events.shutdown(v1110);
    l_v1061_1:set_callback(v1118, true);
    l_v1061_1.fov:set_callback(v1118);
    l_v1061_1.offset_x:set_callback(v1118);
    l_v1061_1.offset_y:set_callback(v1118);
    l_v1061_1.offset_z:set_callback(v1118);
    local function v1123(v1119)
        -- upvalues: v265 (ref), v1109 (ref), l_v1062_1 (ref)
        local l_weapon_info_0 = v265.weapon_info;
        if v1119.weaponselect ~= 0 or l_weapon_info_0 == nil then
            return;
        else
            local v1121 = l_weapon_info_0.weapon_type == 0;
            local v1122 = v1109.righthand == 1 and 0 or 1;
            l_v1062_1.cl_righthand:int(v1121 and v1122 or v1109.righthand, true);
            return;
        end;
    end;
    local function v1127(_, _, v1126)
        -- upvalues: l_v1061_1 (ref), v1109 (ref)
        if l_v1061_1:get() and l_v1061_1.opposite_knife:get() then
            v1109.righthand = tonumber(v1126);
        end;
    end;
    local function v1128()
        -- upvalues: l_v1061_1 (ref), v71 (ref), v1123 (ref), l_v1062_1 (ref), v1127 (ref), v72 (ref), v1109 (ref)
        if l_v1061_1:get() and l_v1061_1.opposite_knife:get() then
            v71("createmove", v1123);
            l_v1062_1.cl_righthand:set_callback(v1127);
        else
            v72("createmove", v1123);
            l_v1062_1.cl_righthand:unset_callback(v1127);
            l_v1062_1.cl_righthand:int(v1109.righthand, true);
        end;
    end;
    l_v1061_1:set_callback(v1128, true);
    l_v1061_1.opposite_knife:set_callback(v1128);
end;
v634 = nil;
v1061 = v53.features.world:switch("\v\f<expand-wide>     \rAspect ratio", false, nil, function(v1129)
    return {
        amount = v1129:slider("", 100, 250, 140, 0.01)
    }, true;
end);
v51.new("aspect_ratio", v1061, v70.features.visual);
v1062 = 1.78;
local l_r_aspectratio_0 = cvar.r_aspectratio;
do
    local l_v1061_2, l_v1062_2, l_l_r_aspectratio_0_0 = v1061, v1062, l_r_aspectratio_0;
    local function v1134()
        -- upvalues: l_l_r_aspectratio_0_0 (ref)
        l_l_r_aspectratio_0_0:int(0);
    end;
    local v1135 = nil;
    v1135 = function()
        -- upvalues: l_v1061_2 (ref), l_v1062_2 (ref), v536 (ref), l_l_r_aspectratio_0_0 (ref), v1134 (ref), v72 (ref), v1135 (ref)
        local v1136 = l_v1061_2.value and l_v1061_2.amount.value * 0.01 or 1.78;
        l_v1062_2 = v536(l_v1062_2, v1136, 10);
        if l_l_r_aspectratio_0_0:float() == l_v1062_2 then
            if not l_v1061_2.value then
                v1134();
            end;
            v72("render", v1135);
        else
            l_l_r_aspectratio_0_0:float(l_v1062_2, true);
        end;
    end;
    local function v1137()
        -- upvalues: v71 (ref), v1135 (ref)
        v71("render", v1135);
    end;
    l_v1061_2:set_event("shutdown", v1134);
    l_v1061_2:set_callback(v1137, true);
    l_v1061_2.amount:set_callback(v1137, true);
end;
v1061 = nil;
v1062 = v53.features.breakers:switch(" \v\f<person-skating>     \rAnim. breaker", false, nil, function(v1138)
    local v1139 = {
        air = v1138:combo("\v\f<arrow-up>    \rAir", {
            [1] = "None", 
            [2] = "Static", 
            [3] = "Walking"
        }), 
        move = v1138:combo("\v\f<arrow-down>    \rGround", {
            [1] = "None", 
            [2] = "Slide", 
            [3] = "Shake", 
            [4] = "Walking"
        }), 
        other = v1138:selectable("\v\f<code-compare>    \rOther", {
            [1] = "Flashed", 
            [2] = "Move lean", 
            [3] = "Landing pitch", 
            [4] = "Static creeping"
        })
    };
    v1139.lean_weight = v1138:slider("\a[grey]\f<angle>     \rLean weight", 0, 100, 100, 1, "%"):depend({
        [1] = nil, 
        [2] = "Move lean", 
        [1] = v1139.other
    });
    return v1139, true;
end);
v51.new("anim_breaker", v1062, v70.features.visual);
l_r_aspectratio_0 = ffi.typeof("        struct {\t\t\t\t\t\t\t\t\t\tchar pad_0x0000[0x18];\n            int\tsequence;\n            float\t\tprev_cycle;\n            float\t\tweight;\n            float\t\tweight_delta_rate;\n            float\t\tplayback_rate;\n            float\t\tcycle;\n            void\t\t*entity;\t\t\t\t\t\tchar pad_0x0038[0x4];\n        } **\n    ");
do
    local l_v1062_3, l_l_r_aspectratio_0_1 = v1062, l_r_aspectratio_0;
    local function v1147(v1142)
        -- upvalues: v265 (ref), v230 (ref), v52 (ref), l_l_r_aspectratio_0_1 (ref), l_v1062_3 (ref)
        local l_me_6 = v265.me;
        local l_anim_state_0 = v265.anim_state;
        if not l_me_6 or not l_anim_state_0 or not v230(l_me_6) then
            return;
        elseif v1142 ~= l_me_6 then
            return;
        else
            v52.movement:override();
            local v1145 = ffi.cast(l_l_r_aspectratio_0_1, ffi.cast("uintptr_t", v1142[0]) + 10640)[0];
            local v1146 = not l_anim_state_0.on_ground;
            if l_v1062_3.move.value == "Slide" then
                v52.movement:override("Sliding");
                l_me_6.m_flPoseParameter[0] = 0;
            end;
            if l_v1062_3.move.value == "Walking" then
                v52.movement:override("Walking");
                l_me_6.m_flPoseParameter[7] = 0;
            end;
            if l_v1062_3.move.value == "Shake" then
                v52.movement:override("Sliding");
                l_me_6.m_flPoseParameter[0] = globals.tickcount % 4 > 1 and 0.5 or 0;
            end;
            if l_v1062_3.air.value == "Static" then
                l_me_6.m_flPoseParameter[6] = 1;
            end;
            if l_v1062_3.air.value == "Walking" and v1146 then
                v1145[6].weight = 1;
                l_me_6.m_flPoseParameter[7] = 0;
            end;
            if l_v1062_3.other:get(1) then
                v1145[0].sequence = 227;
            end;
            if l_v1062_3.other:get(2) then
                v1145[12].weight = l_v1062_3.lean_weight.value * 0.01;
            end;
            if l_v1062_3.other:get(3) and l_anim_state_0.landing and not v1146 then
                l_me_6.m_flPoseParameter[12] = 0.5;
            end;
            if l_v1062_3.other:get(4) then
                l_me_6.m_flPoseParameter[8] = 0;
            end;
            return;
        end;
    end;
    local function v1148()
        -- upvalues: v52 (ref)
        v52.movement:override();
    end;
    l_v1062_3:set_event("post_update_clientside_animation", v1147);
    events.shutdown(v1148);
    l_v1062_3:set_callback(function(v1149)
        -- upvalues: v1148 (ref)
        if not v1149.value then
            v1148();
        end;
    end);
end;
v1062 = nil;
l_r_aspectratio_0 = v53.features.movement:switch("\v\f<line-height>    \rFast ladder");
l_r_aspectratio_0:tooltip("\v\f<circle-info>   \rAllow you to climb ladders more quickly");
v51.new("fast_ladder", l_r_aspectratio_0, v70.features.misc);
l_r_aspectratio_0:set_event("createmove", function(v1150)
    -- upvalues: v265 (ref)
    local l_me_7 = v265.me;
    if not l_me_7 or not v265.is_alive then
        return;
    elseif l_me_7.m_MoveType ~= 9 then
        return;
    else
        if v1150.forwardmove > 0 then
            if v1150.view_angles.x < 45 then
                v1150.view_angles.x = 89;
                v1150.in_moveright = 1;
                v1150.in_moveleft = 0;
                v1150.in_forward = 0;
                v1150.in_back = 1;
                if v1150.sidemove == 0 then
                    v1150.view_angles.y = v1150.view_angles.y + 90;
                end;
                if v1150.sidemove < 0 then
                    v1150.view_angles.y = v1150.view_angles.y + 150;
                end;
                if v1150.sidemove > 0 then
                    v1150.view_angles.y = v1150.view_angles.y + 30;
                end;
            end;
        elseif v1150.forwardmove < 0 then
            v1150.view_angles.x = 89;
            v1150.in_moveleft = 1;
            v1150.in_moveright = 0;
            v1150.in_forward = 1;
            v1150.in_back = 0;
            if v1150.sidemove == 0 then
                v1150.view_angles.y = v1150.view_angles.y + 90;
            end;
            if v1150.sidemove > 0 then
                v1150.view_angles.y = v1150.view_angles.y + 150;
            end;
            if v1150.sidemove < 0 then
                v1150.view_angles.y = v1150.view_angles.y + 30;
            end;
        end;
        return;
    end;
end);
l_r_aspectratio_0 = nil;
local v1152 = v53.features.movement:switch(" \v\f<person-falling>    \rNo fall damage");
v1152:tooltip("\v\f<circle-info>   \rAvoid getting hit when falling from a height when possible");
v51.new("no_fall_damage", v1152, v70.features.misc);
v1152:set_event("createmove", function(v1153)
    -- upvalues: v265 (ref)
    local l_me_8 = v265.me;
    local l_origin_0 = v265.origin;
    if not l_me_8 or not l_origin_0 then
        return;
    else
        if l_me_8.m_vecVelocity.z <= -500 then
            if utils.trace_line(l_origin_0, l_origin_0 - vector(0, 0, 15)).fraction ~= 1 then
                v1153.in_duck = 0;
            elseif utils.trace_line(l_origin_0, l_origin_0 - vector(0, 0, 50)).fraction ~= 1 then
                v1153.in_duck = 1;
            end;
        end;
        return;
    end;
end);
v1152 = nil;
local v1156 = v53.features.movement:switch("\v\f<person-walking-arrow-loop-left>    \rAvoid collisions");
v1156:tooltip("\v\f<circle-info>   \rAvoid getting hit when falling from a height when possible");
v51.new("avoid_collisions", v1156, v70.features.misc);
local function v1159(v1157, v1158)
    return vector():angles(v1157, v1158);
end;
do
    local l_v1159_0 = v1159;
    v1156:set_event("createmove", function(v1161)
        -- upvalues: v265 (ref), l_v1159_0 (ref)
        local l_me_9 = v265.me;
        local l_origin_1 = v265.origin;
        local l_camera_angles_1 = v265.camera_angles;
        if not l_me_9 or not l_origin_1 or not l_camera_angles_1 then
            return;
        else
            local v1165 = l_me_9.m_vecVelocity:length();
            local v1166 = 7;
            local l_huge_0 = math.huge;
            local l_huge_1 = math.huge;
            for v1169 = 20, 180, 20 do
                local l_x_0 = l_v1159_0(0, l_camera_angles_1.y + v1169 - 90).x;
                local l_y_0 = l_v1159_0(0, l_camera_angles_1.y + v1169 - 90).y;
                local _ = l_v1159_0(0, l_camera_angles_1.y).z;
                local v1173 = l_origin_1.x + l_x_0 * 70;
                local v1174 = l_origin_1.y + l_y_0 * 70;
                local v1175 = l_origin_1.z + 60;
                local v1176 = utils.trace_line(l_origin_1, vector(v1173, v1174, v1175), nil, nil, 1);
                if l_origin_1:dist(v1176.end_pos) < l_huge_0 then
                    l_huge_0 = l_origin_1:dist(v1176.end_pos);
                    l_huge_1 = v1169;
                end;
            end;
            if l_huge_0 < 25 + v1166 and v1161.in_jump and not v1161.in_moveright and not v1161.in_moveleft and not v1161.in_back then
                v1161.forwardmove = math.abs(v1165 * math.cos(math.rad(l_huge_1)));
                if math.abs(l_huge_1 - 90) < 40 then
                    side_velo = v1165 * math.sin(math.rad(l_huge_1)) * (25 + v1166 - l_huge_0) / 15;
                else
                    side_velo = v1165 * math.sin(math.rad(l_huge_1));
                end;
                if l_huge_1 >= 90 then
                    v1161.sidemove = side_velo;
                else
                    v1161.sidemove = side_velo * -1;
                end;
            end;
            return;
        end;
    end);
end;
v1156 = nil;
v1159 = v53.features.game_focus:switch("\v\f<terminal>    \rConsole color", false, nil, {
    [1] = nil, 
    [2] = true, 
    [1] = color("3838389A")
});
v51.new("console_color", v1159, v70.features.misc);
local v1177 = {};
local v1178 = {
    [1] = "vgui_white", 
    [2] = "vgui/hud/800corner1", 
    [3] = "vgui/hud/800corner2", 
    [4] = "vgui/hud/800corner3", 
    [5] = "vgui/hud/800corner4"
};
do
    local l_v1159_1, l_v1177_0, l_v1178_0 = v1159, v1177, v1178;
    (function()
        -- upvalues: l_v1177_0 (ref), l_v1178_0 (ref)
        l_v1177_0 = {};
        for _, v1183 in ipairs(l_v1178_0) do
            local v1184 = materials.get(v1183);
            if v1184 == nil then
                v1184 = materials.get_materials(v1183)[1];
            end;
            if v1184 ~= nil and v1184.is_valid(v1184) then
                l_v1177_0[v1183] = v1184;
            end;
        end;
    end)();
    local v1185 = nil;
    local v1186 = utils.get_vfunc("engine.dll", "VEngineClient014", 11, "bool(__thiscall*)(void*)");
    local function v1190(v1187)
        -- upvalues: v1186 (ref), v1185 (ref), l_v1177_0 (ref)
        if not v1186() then
            v1187 = color();
        end;
        if v1185 == v1187 then
            return;
        else
            for _, v1189 in pairs(l_v1177_0) do
                v1189:alpha_modulate(v1187.a / 255);
                v1189:color_modulate(color(v1187.r, v1187.g, v1187.b));
            end;
            v1185 = v1187;
            return;
        end;
    end;
    local function v1191()
        -- upvalues: v1190 (ref), l_v1159_1 (ref)
        v1190(l_v1159_1.color.value);
    end;
    local function v1192()
        -- upvalues: v1190 (ref)
        v1190(color());
    end;
    l_v1159_1:set_event("render", v1191);
    l_v1159_1:set_event("shutdown", v1192);
    l_v1159_1:set_callback(v1192);
end;
v1159 = nil;
v1177 = v53.features.game_focus:switch("\v\f<lightbulb-on>   \rFlash game icon");
v1177:tooltip("\v\f<circle-info>   \rAllows you to avoid bumping into walls and losing speed");
v51.new("flask_game_icon", v1177, v70.features.misc);
do
    local l_v1177_1, l_v1178_1 = v1177, v1178;
    l_v1178_1 = function()
        -- upvalues: l_v1177_1 (ref)
        ffi.cdef("            int GetForegroundWindow();\n            bool FlashWindow(int hwnd, bool invert);\n            int FindWindowA(const char* class, const char* name);\n        ");
        local v1195 = ffi.load("user32");
        local v1196 = v1195.FindWindowA("Valve001", "Counter-Strike: Global Offensive - Direct3D 9");
        local function v1197()
            -- upvalues: v1195 (ref), v1196 (ref)
            return v1195.GetForegroundWindow() == v1196;
        end;
        l_v1177_1:set_event("round_start", function()
            -- upvalues: v1197 (ref), v1195 (ref), v1196 (ref)
            if not v1197() then
                v1195.FlashWindow(v1196, true);
            end;
        end);
    end;
    local v1198 = false;
    local function v1199()
        -- upvalues: l_v1177_1 (ref), v1198 (ref), l_v1178_1 (ref)
        if l_v1177_1.value and not v1198 then
            v1198 = true;
            l_v1178_1();
        end;
    end;
    v1199();
    l_v1177_1:set_callback(v1199);
end;
v1177 = nil;
v1178 = v53.features.game_focus:switch(" \v\f<user>    \rClient-side nickname", false, nil, function(v1200)
    return {
        input = v1200:input("\v\f<text>   \rNickname", "prince")
    }, true;
end);
v1178:tooltip("\v\f<circle-info>   \rThis nickname will only be visible to you in the kill-feed, scoreboard, etc");
v51.new("client_side_nickname", v1178, v70.features.misc);
local v1201 = {
    local_client_base = ffi.cast("uintptr_t**", utils.opcode_scan("engine.dll", "A1 ? ? ? ? 0F 28 C1 F3 0F 5C 80 ? ? ? ? F3 0F 11 45 ? A1 ? ? ? ? 56 85 C0 75 04 33 F6 EB 26 80 78 14 00 74 F6 8B 4D 08 33 D2 E8 ? ? ? ? 8B F0 85 F6", 1)), 
    player_struct = ffi.typeof("            struct {\n                int64_t         unknown;\n                int64_t         steamID64;\n                char            szName[128];\n                int             userId;\n                char            szSteamID[20];\n                char            pad_0x00A8[0x10];\n                unsigned long   iSteamID;\n                char            szFriendsName[128];\n                bool            fakeplayer;\n                bool            ishltv;\n                unsigned int    customfiles[4];\n                unsigned char   filesdownloaded;\n            }\n        ")
};
v1201.get_userdata = utils.get_vfunc(11, ffi.typeof("$*(__thiscall*)(void*, int, int*)", v1201.player_struct));
do
    local l_v1178_2, l_v1201_0 = v1178, v1201;
    local function v1207(v1204)
        -- upvalues: v265 (ref), l_v1201_0 (ref)
        local l_me_10 = v265.me;
        if not l_me_10 then
            return;
        else
            l_v1201_0.local_client = l_v1201_0.local_client_base[0][0];
            if not l_v1201_0.local_client then
                return;
            else
                l_v1201_0.userinfo = ffi.cast("void***", l_v1201_0.local_client + 21184)[0];
                if not l_v1201_0.userinfo then
                    return;
                else
                    local v1206 = l_v1201_0.get_userdata(l_v1201_0.userinfo, l_me_10:get_index() - 1, nil);
                    if not v1206 then
                        return;
                    else
                        if ffi.string(v1206[0].szName) ~= v1204 then
                            v1206[0].szName = ffi.new("char[128]", v1204);
                        end;
                        return;
                    end;
                end;
            end;
        end;
    end;
    local function v1208()
        -- upvalues: v1207 (ref)
        v1207(panorama.MyPersonaAPI.GetName());
    end;
    local function v1210()
        -- upvalues: l_v1178_2 (ref), v1207 (ref), v1208 (ref)
        local l_value_6 = l_v1178_2.input.value;
        if l_v1178_2.value and #l_value_6 > 0 then
            return v1207(l_value_6);
        else
            v1208();
            return;
        end;
    end;
    v1210();
    l_v1178_2:set_callback(v1210);
    l_v1178_2.input:set_callback(v1210);
    l_v1178_2:set_event("shutdown", v1208);
    l_v1178_2:set_event("round_prestart", v1210);
    l_v1178_2:set_event("player_connect_full", v1210);
end;
v1178 = nil;
v1201 = v53.features.grenade_features:switch(" \v\f<arrow-down-left-and-arrow-up-right-to-center>    \rSuper toss");
v1201:tooltip("\v\f<circle-info>   \rCompensates for the trajectory of a grenade when moving");
v51.new("super_toss", v1201, v70.features.misc);
local v1211 = false;
local function v1221(v1212, v1213, v1214, v1215)
    -- upvalues: v35 (ref)
    local v1216 = vector():angles(v1212.x - 10 + math.abs(v1212.x) / 9, v1212.y);
    local v1217 = v35(v1214 * 0.9, 15, 750) * (v35(v1215, 0, 1) * 0.7 + 0.3);
    local l_v1216_0 = v1216;
    for _ = 1, 8 do
        l_v1216_0 = (v1216 * (l_v1216_0 * v1217 + v1213 * 1.25):length() - v1213 * 1.25) / v1217;
        l_v1216_0:normalize();
    end;
    local v1220 = l_v1216_0.angles(l_v1216_0);
    if v1220.x > -10 then
        v1220.x = 0.9 * v1220.x + 9;
    else
        v1220.x = 1.125 * v1220.x + 11.25;
    end;
    return v1220;
end;
do
    local l_v1211_0, l_v1221_0 = v1211, v1221;
    local function v1228(v1224)
        -- upvalues: v265 (ref), l_v1221_0 (ref)
        local l_me_11 = v265.me;
        local l_weapon_1 = v265.weapon;
        local l_weapon_info_1 = v265.weapon_info;
        if not l_me_11 or not v265.is_alive or not l_weapon_1 or not l_weapon_info_1 or not l_weapon_info_1.throw_velocity or not l_weapon_1.m_flThrowStrength then
            return;
        else
            v1224.angles = l_v1221_0(v1224.angles, v1224.velocity, l_weapon_info_1.throw_velocity, l_weapon_1.m_flThrowStrength);
            return;
        end;
    end;
    local function v1234(v1229)
        -- upvalues: l_v1211_0 (ref), v52 (ref), v265 (ref), l_v1221_0 (ref)
        if l_v1211_0 then
            l_v1211_0 = false;
            v52.air_strafe:override();
            v52.strafe_assist:override();
        end;
        if not v1229.jitter_move then
            return;
        else
            local l_me_12 = v265.me;
            local l_weapon_2 = v265.weapon;
            local l_weapon_info_2 = v265.weapon_info;
            if not l_me_12 or not v265.is_alive or not l_weapon_2 or not l_weapon_info_2 or not l_weapon_info_2.throw_velocity or not l_weapon_2.m_flThrowStrength then
                return;
            elseif l_weapon_info_2.weapon_type ~= 9 or l_weapon_2.m_fThrowTime <= 0 or l_weapon_2.m_fThrowTime - 0.1 * v265.exploit_charge > globals.curtime then
                return;
            else
                l_v1211_0 = true;
                v52.air_strafe:override(false);
                v52.strafe_assist:override(false);
                local v1233 = l_me_12:simulate_movement();
                v1233:think();
                v1229.view_angles = l_v1221_0(v1229.view_angles, v1233.velocity, l_weapon_info_2.throw_velocity, l_weapon_2.m_flThrowStrength);
                return;
            end;
        end;
    end;
    v1201:set_callback(function(v1235)
        -- upvalues: v52 (ref)
        if not v1235.value then
            v52.air_strafe:override();
            v52.strafe_assist:override();
        end;
    end);
    v1201:set_event("createmove", v1234);
    v1201:set_event("grenade_override_view", v1228);
end;
v1201 = nil;
v1211 = v53.features.grenade_features:switch("\v\f<hand-sparkles>    \rAuto release", false, nil, function(v1236)
    return {
        on_pin_pulled = v1236:switch("\v\f<circle-notch>    \rOn pin pulled"), 
        release_damage = v1236:slider("\v\f<wine-bottle>    \rMin. damage", 1, 60, 20), 
        allowed_grenades = v1236:listable("", {
            [1] = "Molotov", 
            [2] = "High Explosive"
        })
    }, true;
end);
v1211:tooltip("\v\f<circle-info>   \rCompensates for the trajectory of a grenade when moving");
v51.new("auto_release", v1211, v70.features.misc);
v1221 = {
    CIncendiaryGrenade = 1, 
    CMolotovGrenade = 1, 
    CHEGrenade = 2
};
local v1237 = 0;
do
    local l_v1211_1, l_v1221_1, l_v1237_0 = v1211, v1221, v1237;
    local function v1242(v1241)
        -- upvalues: l_v1237_0 (ref)
        if v1241.type == "Frag" or v1241.type == "Molly" then
            l_v1237_0 = v1241.damage;
            return;
        else
            l_v1237_0 = 0;
            return;
        end;
    end;
    l_v1211_1:set_event("createmove", function(v1243)
        -- upvalues: v265 (ref), l_v1221_1 (ref), l_v1211_1 (ref), l_v1237_0 (ref)
        local l_me_13 = v265.me;
        local l_weapon_3 = v265.weapon;
        if not l_me_13 or not l_weapon_3 then
            return;
        else
            local v1246 = l_v1221_1[l_weapon_3:get_classname()];
            if not v1246 then
                return;
            elseif not l_v1211_1.allowed_grenades:get(v1246) then
                return;
            elseif l_v1237_0 < l_v1211_1.release_damage.value then
                return;
            else
                if l_v1211_1.on_pin_pulled.value then
                    if v1243.in_attack and l_weapon_3.m_bPinPulled then
                        v1243.in_attack = false;
                    end;
                else
                    if v1243.in_attack and l_weapon_3.m_bPinPulled then
                        v1243.in_attack = false;
                    end;
                    if not l_weapon_3.m_bPinPulled then
                        v1243.in_attack = true;
                    end;
                end;
                return;
            end;
        end;
    end);
    l_v1211_1:set_event("grenade_prediction", v1242);
end;
v1211 = nil;
v1221 = v53.features.grenade_features:switch(" \v\f<bomb>    \rDrop grenades");
v1221:tooltip("\v\f<circle-info>  \rThrows out all grenades. \ac2a04affBind to hold!");
v51.new("drop_grenades", v1221, v70.features.misc);
v1237 = {
    CIncendiaryGrenade = "weapon_incgrenade", 
    CMolotovGrenade = "weapon_molotov", 
    CHEGrenade = "weapon_hegrenade"
};
local v1247 = false;
do
    local l_v1221_2, l_v1237_1, l_v1247_0 = v1221, v1237, v1247;
    local function v1260(v1251)
        -- upvalues: v265 (ref), l_v1221_2 (ref), l_v1247_0 (ref), l_v1237_1 (ref)
        local l_me_14 = v265.me;
        local l_weapons_0 = v265.weapons;
        if not l_me_14 or not l_weapons_0 then
            return;
        else
            local l_value_7 = l_v1221_2.value;
            if l_value_7 then
                v1251.in_use = true;
                if not l_v1247_0 then
                    local v1255 = 1;
                    for _, v1257 in ipairs(l_weapons_0) do
                        local v1258 = l_v1237_1[v1257:get_classname()];
                        do
                            local l_v1258_0 = v1258;
                            if l_v1258_0 then
                                utils.execute_after(0.02 * v1255, function()
                                    -- upvalues: l_v1258_0 (ref)
                                    utils.console_exec("use " .. l_v1258_0 .. "; drop");
                                end);
                            end;
                            v1255 = v1255 + 1;
                        end;
                    end;
                end;
            end;
            l_v1247_0 = l_value_7;
            return;
        end;
    end;
    events.createmove(v1260);
end;
v1221 = nil;
v1237 = v53.features.scoreboard:switch("\v\f<tag>     \rClantag");
v51.new("clantag", v1237, v70.features.misc);
v1247 = {
    [1] = "", 
    [2] = "6", 
    [3] = "e7", 
    [4] = "ev4", 
    [5] = "eva7", 
    [6] = "eval2", 
    [7] = "evala5", 
    [8] = "evalat3", 
    [9] = "evalate$", 
    [10] = "evalate.7", 
    [11] = "evalate.c9", 
    [12] = "evalate.co#", 
    [13] = "evalate.com", 
    [14] = "evalate.com", 
    [15] = "evalate.com", 
    [16] = "evalate.com", 
    [17] = "evalate.com", 
    [18] = "evalate.co#", 
    [19] = "evalate.c9", 
    [20] = "evalate.7", 
    [21] = "evalate$", 
    [22] = "evalat3", 
    [23] = "evala5", 
    [24] = "eval2", 
    [25] = "eva7", 
    [26] = "ev4", 
    [27] = "e7", 
    [28] = "6", 
    [29] = ""
};
local v1261 = "";
local v1262 = 17;
do
    local l_v1247_1, l_v1261_0, l_v1262_0 = v1247, v1261, v1262;
    local function v1267(v1266)
        -- upvalues: l_v1261_0 (ref)
        if v1266 ~= l_v1261_0 then
            l_v1261_0 = v1266;
            common.set_clan_tag(v1266);
        end;
    end;
    local function v1273()
        -- upvalues: v265 (ref), l_v1262_0 (ref), l_v1247_1 (ref), v1267 (ref)
        if not globals.is_connected then
            return;
        else
            local l_net_channel_0 = v265.net_channel;
            if not l_net_channel_0 then
                return;
            else
                local v1269 = l_net_channel_0.latency[1] or 0;
                local v1270 = to_ticks(v1269);
                local v1271 = globals.tickcount + v1270;
                local v1272 = math.floor(v1271 / l_v1262_0) % #l_v1247_1 + 1;
                v1267(l_v1247_1[v1272]);
                return;
            end;
        end;
    end;
    local function v1274()
        -- upvalues: v1267 (ref)
        v1267("");
    end;
    v1237:set_event("render", v1273);
    v1237:set_event("shutdown", v1274);
    v1237:set_callback(v1274);
end;
v1237 = nil;
v1247 = {};
v1261 = {
    mute = utils.get_vfunc("client.dll", "GameClientExports001", 2, "void(__thiscall*)(void*, int idx)"), 
    unmute = utils.get_vfunc("client.dll", "GameClientExports001", 3, "void(__thiscall*)(void*, int idx)"), 
    is_muted = utils.get_vfunc("client.dll", "GameClientExports001", 1, "bool(__thiscall*)(void*, int idx)")
};
v1262 = v53.features.scoreboard:switch("\v\f<face-woozy>    \rVoice state", false, nil, function(v1275)
    return {
        state = v1275:list("", " \v\f<microphone>    \rUnmute", "\v\f<microphone-slash>   \rMute")
    }, true;
end);
v1262:tooltip("\v\f<circle-info>  \rYou can unmute players, also mute everyone");
v51.new("voice_state", v1262, v70.features.misc);
do
    local l_v1247_2, l_v1261_1, l_v1262_1 = v1247, v1261, v1262;
    local function v1287()
        -- upvalues: v265 (ref), v230 (ref), l_v1262_1 (ref), l_v1261_1 (ref), l_v1247_2 (ref)
        local l_me_15 = v265.me;
        local l_players_0 = v265.players;
        if not l_me_15 or not l_players_0 then
            return;
        else
            for _, v1282 in ipairs(l_players_0) do
                local l_entity_1 = v1282.entity;
                if v230(l_entity_1) and l_entity_1 ~= l_me_15 then
                    local v1284 = l_entity_1:get_name();
                    local v1285 = l_entity_1:get_index();
                    local v1286 = string.format("%s::%s", v1284, v1285);
                    if l_v1262_1.state:get() == 1 and l_v1261_1.is_muted(v1285) == true and l_v1247_2[v1286] ~= "unmuted" then
                        l_v1261_1.unmute(v1285);
                        l_v1247_2[v1286] = "unmuted";
                    end;
                    if l_v1262_1.state:get() == 2 and l_v1261_1.is_muted(v1285) == false and l_v1247_2[v1286] ~= "muted" then
                        l_v1261_1.mute(v1285);
                        l_v1247_2[v1286] = "muted";
                    end;
                end;
            end;
            return;
        end;
    end;
    local function v1291()
        -- upvalues: l_v1247_2 (ref), v265 (ref), v230 (ref), l_v1261_1 (ref)
        l_v1247_2 = {};
        local l_players_1 = v265.players;
        if not l_players_1 then
            return;
        else
            for _, v1290 in ipairs(l_players_1) do
                if v230(v1290.entity) then
                    l_v1261_1.unmute(v1290.entity:get_index());
                end;
            end;
            return;
        end;
    end;
    l_v1262_1:set_event("render", v1287);
    l_v1262_1:set_event("shutdown", v1291);
    l_v1262_1:set_event("level_init", v1291);
    l_v1262_1:set_callback(v1291);
end;
v1247 = nil;
v1261 = v53.features.scoreboard:switch("\v\f<screencast>    \rShared icon");
v51.new("shared_icon", v1261, v70.features.misc);
v1262 = {
    ["GS Pro"] = "https://raw.githubusercontent.com/kissprince/evalate-shared-logo/refs/heads/main/gs-debug-pro.png", 
    ["NL Pro"] = "https://raw.githubusercontent.com/kissprince/evalate-shared-logo/refs/heads/main/nl-evalate-pro.png", 
    ["GS Debug"] = "https://raw.githubusercontent.com/kissprince/evalate-shared-logo/refs/heads/main/gs-evalate-debug.png", 
    ["NL Recode"] = "https://raw.githubusercontent.com/kissprince/evalate-shared-logo/refs/heads/main/nl-evalate-recode.png", 
    ["GS Stable"] = "https://raw.githubusercontent.com/kissprince/evalate-shared-logo/refs/heads/main/gs-evalate.png", 
    ["NL Stable"] = "https://raw.githubusercontent.com/kissprince/evalate-shared-logo/refs/heads/main/nl-evalate.png", 
    ["NL Trial"] = "https://raw.githubusercontent.com/kissprince/evalate-shared-logo/refs/heads/main/nl-evalate-trial.png"
};
do
    local l_v1262_2 = v1262;
    local function v1302()
        -- upvalues: v79 (ref), v265 (ref), v230 (ref), v103 (ref), l_v1262_2 (ref)
        if globals.tickcount % 64 ~= 0 then
            return;
        elseif not v79 then
            return;
        else
            local v1293 = {};
            for _, v1295 in ipairs(v79) do
                v1293[v1295.secret] = string.format("%s %s", v1295.cheat, v1295.build_name);
            end;
            for _, v1297 in ipairs(v265.players) do
                local l_entity_2 = v1297.entity;
                if l_entity_2 and v230(l_entity_2) then
                    local v1299 = l_entity_2:get_player_info();
                    if v1299 then
                        local v1300 = v1293[v103(v1299.steamid64)];
                        if v1300 then
                            local v1301 = l_v1262_2[v1300];
                            if v1301 then
                                l_entity_2:set_icon(v1301);
                            end;
                        end;
                    end;
                end;
            end;
            return;
        end;
    end;
    local function v1306()
        -- upvalues: v265 (ref), v230 (ref)
        for _, v1304 in ipairs(v265.players) do
            local l_entity_3 = v1304.entity;
            if l_entity_3 and v230(l_entity_3) then
                l_entity_3:set_icon();
            end;
        end;
    end;
    events.shutdown(v1306);
    v1261:set_event("net_update_end", v1302);
    v1261:set_callback(function(v1307)
        -- upvalues: v1306 (ref)
        if not v1307.value then
            v1306();
        end;
    end);
end;
v1261 = nil;
v1262 = 2;
local v1311 = v53.features.unlocks:switch("\v\f<trash>     \rTrashtalk", false, nil, function(v1308)
    local v1309 = {
        events = v1308:listable("\v\f<check>   \rEvents", {
            [1] = "On Kill", 
            [2] = "On Death"
        }), 
        style = v1308:list("\v\f<font>   \rStyle", {
            [1] = "Simple", 
            [2] = "Russian", 
            [3] = "English"
        })
    };
    local function v1310()
        -- upvalues: v1309 (ref)
        return #v1309.events.value > 0;
    end;
    v1309.style:depend({
        [1] = v1309.events, 
        [2] = v1310
    });
    return v1309, true;
end);
v51.set_callback_list(v1311.style, true);
v51.new("trashtalk", v1311, v70.features.misc);
local v1312 = {
    [1] = {
        on_kill = {
            [1] = "1"
        }, 
        on_death = {}
    }, 
    [2] = {
        on_kill = {
            [1] = "\208\180\209\139\208\188 \208\180\209\139\208\188 \208\186\208\176\208\183\208\184\208\189\208\190 \208\184 \208\177\208\187\209\143\208\180\208\184", 
            [2] = "\208\189\208\184\209\135\208\181 \209\134\208\181\208\183\208\176\209\128\209\140 \209\130\208\190\208\182\208\181 \208\189\208\181 \209\129\209\128\208\176\208\183\209\131 \209\129\208\176\208\187\208\176\209\130\208\190\208\188 \209\129\209\130\208\176\208\187", 
            [3] = "evalate.com/competition", 
            [4] = "\209\143 \208\189\208\176 \208\191\208\181\209\128\208\178\208\190\208\188 \208\188\208\181\209\129\209\130\208\181 \209\135\208\181\208\186\208\176\208\185  evalate.com/leaderboard", 
            [5] = "\209\130\209\139 \208\178\208\184\208\180\208\181\208\187 \208\188\208\190\208\184 \208\190\208\179\209\128\208\190\208\188\208\189\209\139\208\181 \209\143\208\185\209\134\208\176?!?!?!?!...", 
            [6] = "\208\178\209\133 \209\128\208\184\208\191\208\189\209\131\208\187\208\190\209\129\209\140 \209\129\208\190\209\128\208\184 \209\135\209\130\208\190 \209\131\208\177\208\184\208\187", 
            [7] = "\208\178\209\129\209\143 \208\186\208\190\208\189\209\129\208\190\208\187\209\140 \208\178 \209\130\208\178\208\190\208\184\209\133 \209\129\208\188\208\181\209\128\209\130\209\143\209\133", 
            [8] = nil, 
            [9] = "\208\184\208\177\208\190 \208\189\208\181\209\133\209\131\208\185 \209\130\208\181\208\177\208\181 \209\130\209\139\209\128\208\186\208\176\209\130\209\140 \208\191\208\190 \208\186\208\187\208\176\208\178\208\184\208\176\209\130\209\131\209\128\208\181 \208\184 \208\189\208\176\208\180\208\181\208\181\209\130\209\129\209\143 \208\189\208\176 \209\131\208\180\208\176\209\135\209\131", 
            [10] = "\209\133\208\176, \208\190\208\177\208\181\208\183\209\140\209\143\208\189\208\186\208\176, \209\131\208\177\208\184\208\187 \209\130\208\181\208\177\209\143", 
            [11] = nil, 
            [12] = "\209\130\208\181\208\177\208\181 \208\178\209\128\208\181\208\188\209\143 \208\180\208\187\209\143 \209\130\209\128\208\184\208\176\208\187 \208\178\208\181\209\128\209\129\208\184\208\184 evalate \208\178\209\139\208\180\208\176\209\130\209\140 \208\184\208\187\208\184 \209\135\209\130\208\190?", 
            [13] = "\208\191\208\190\208\184\208\179\209\128\208\176\208\185 \209\129 \209\130\209\128\208\184\208\176\208\187\208\190\208\188 \208\181\208\178\208\176\208\187\208\181\208\185\209\130\208\176 \209\143 \209\133\208\183 market.neverlose.cc/k3jdRt", 
            [14] = "\226\153\155 \240\157\144\142\240\157\144\150\240\157\144\141\240\157\144\132\240\157\144\131 \240\157\144\129\240\157\144\152 \240\157\144\132\240\157\144\149\240\157\144\128\240\157\144\139\240\157\144\128\240\157\144\147\240\157\144\132 \240\157\144\139\240\157\144\148\240\157\144\142 \226\153\155", 
            [15] = nil, 
            [16] = "\208\186\209\130\208\190 \208\186\208\190\208\189\209\130\209\128\208\190\208\187\208\184\209\128\209\131\208\181\209\130 \208\191\209\143\209\130\208\181\209\128\208\190\209\135\208\186\209\131 \208\178 \209\129\209\131\208\180\208\182\208\181 - \209\130\208\190\209\130 \208\191\209\128\208\176\208\178\208\184\209\130 \208\188\208\184\209\128\208\190\208\188", 
            [17] = "\209\131 \209\130\208\181\208\177\209\143 \208\187\208\176\208\179\208\184 \208\184\208\187\208\184 \209\130\209\139 \208\191\208\190 \208\182\208\184\208\183\208\189\208\184 \209\130\208\176\208\186\208\190\208\185 \208\188\208\181\208\180\208\187\208\181\208\189\208\189\209\139\208\185?", 
            [18] = "\208\162\209\139 \209\129\209\130\209\128\208\181\208\187\209\143\208\181\209\136\209\140 \208\186\208\176\208\186 \208\188\208\190\209\143 \208\177\208\176\208\177\209\131\208\187\209\143, \208\176 \208\190\208\189\208\176 \209\129\208\187\208\181\208\191\208\176\209\143!", 
            [19] = "\208\178\208\190 \208\180\208\181\208\177\208\184\208\187 \209\131\208\188\208\181\209\128 \208\190\208\191\209\143\209\130\209\140", 
            [8] = {
                [1] = "\209\130\208\176\208\186\208\190\208\185 \209\130\209\131\208\191\208\190\209\128\209\139\208\187\209\139\208\185", 
                [2] = "\209\143 \208\178\208\176\209\133\209\131\208\181"
            }, 
            [11] = {
                [1] = "\208\184\208\180\208\184 \208\180\208\184\209\129\208\191\209\131\209\130\208\189\208\184 \209\129\208\178\208\190\209\142 \209\133\209\131\208\185\208\189\209\142", 
                [2] = "\208\189\208\181 \208\177\209\131\209\129\209\130\208\184\209\130 \209\130\208\181\208\177\209\143"
            }, 
            [15] = {
                [1] = "\208\188\208\190\209\135\208\176 \209\130\208\178\208\190\209\143 \208\187\209\131\208\176, \208\179\208\181\209\130\208\189\208\184 \240\157\146\134\240\157\146\151\240\157\146\130\240\157\146\141\240\157\146\130\240\157\146\149\240\157\146\134", 
                [2] = "\208\181\209\129\208\187\208\184 \208\186\208\190\208\189\208\181\209\135\208\189\208\190 \208\180\208\181\208\189\208\181\208\179 \209\133\208\178\208\176\209\130\208\184\209\130 \209\133\208\176\209\133\208\176\209\133\208\176\208\176)"
            }
        }, 
        on_death = {
            [1] = nil, 
            [2] = nil, 
            [3] = "\208\189\209\131 \209\132\209\131 \208\177\208\187\209\143\209\130\209\140", 
            [4] = "\208\189\209\131 \208\181\208\177\208\176\208\189\208\176\209\130 \208\177\208\187\209\143\208\180\209\140", 
            [5] = "\208\189\209\131 \208\188\208\176\208\188\209\131 \208\181\208\177\208\176\208\187 \209\130\209\139 \208\186\208\176\208\186 \209\131\208\177\208\184\208\187 \208\188\208\181\208\189\209\143", 
            [6] = "\209\132\209\131 \208\177\208\187\209\143\208\180\208\190\209\130\208\176 \209\129 \208\189\208\187\208\190\208\188 \209\131\208\177\208\184\208\178\208\176\208\181\209\130 \208\190\208\191\209\143\209\130\209\140", 
            [7] = "\208\176 \209\130\208\184\208\188\208\181\208\185\209\130 \208\186\208\176\208\186 \208\178\209\129\208\181\208\179\208\180\208\176 \208\189\208\176 \208\145", 
            [8] = "\208\154\208\144\208\154 \208\162\208\171 \208\162\208\163\208\162 \208\146\208\171\208\161\208\162\208\160\208\149\208\155\208\152\208\155 \208\148\208\144\208\163\208\157", 
            [9] = "\209\141\209\130\208\190 \209\130\209\139 \209\129\208\186\208\190\208\187\209\140\208\186\208\190 \208\186\208\189\208\190\208\191\208\190\208\186 \208\191\209\128\208\190\208\182\208\176\208\187 \209\135\209\130\208\190\208\177\209\139 \209\131\208\177\208\184\209\130\209\140 \208\188\208\181\208\189\209\143?", 
            [10] = "\209\141\209\130\208\190 \208\178 \209\129\208\186\208\190\208\187\209\140\208\186\208\190 \209\130\208\184\208\186\208\190\208\178?", 
            [11] = "\240\157\144\158\240\157\144\155\240\157\144\154\240\157\144\167\240\157\144\154\240\157\144\173...", 
            [12] = "\208\191\208\190\209\130\209\131\208\182\208\189\208\190", 
            [13] = "\209\130\209\139 \209\130\208\176\208\186 \208\186\208\181\208\188\208\191\208\181\209\128\208\184\209\136\209\140 \209\135\209\130\208\190 \208\191\208\190\209\128\208\176 \209\131\208\182\208\181 \208\191\208\176\208\187\208\176\209\130\208\186\209\131 \209\129\209\130\208\176\208\178\208\184\209\130\209\140", 
            [14] = "\209\131\209\128\208\190\208\180", 
            [15] = nil, 
            [16] = "\209\135\208\184\209\130 \208\181\209\137\208\181 \208\189\208\181 \208\189\208\176\209\131\209\135\208\184\208\187\209\129\209\143 \208\191\209\128\208\181\208\180\208\184\208\186\209\130\208\184\209\130\209\140 \208\188\209\131\208\178\209\139 \209\130\208\176\208\186\208\190\208\179\208\190 \208\180\208\190\208\187\208\177\208\176\208\181\208\177\208\176", 
            [1] = {
                [1] = "\208\191\208\190\208\180\209\129\208\190\209\129 \208\181\208\177\208\176\208\189\209\139\208\185", 
                [2] = "\208\176 \209\130\208\181\208\191\208\181\209\128\209\140 \208\180\209\131\208\188\208\176\208\185, \209\141\209\130\208\190 \209\143 \208\191\208\184\209\136\209\131 \208\184\208\187\208\184 \209\130\209\128\208\181\209\136\209\130\208\190\208\187\208\186", 
                [3] = "\209\133\209\131\208\181\208\179\208\187\208\190\209\130 \208\177\208\187\209\143\208\180\209\140"
            }, 
            [2] = {
                [1] = "\208\189\209\131 \208\189\208\181 \208\189\208\181", 
                [2] = "\208\189\209\131 \209\130\208\176\208\186\208\190\208\185 \208\191\208\184\208\180\208\190\209\128\208\176\209\129 \208\188\208\181\208\189\209\143 \209\131\208\177\208\184\208\187"
            }, 
            [15] = {
                [1] = "\208\180\208\190\208\187\208\177\208\176\208\181\208\177 \209\132\208\181\208\185\208\186 \209\132\208\187\208\184\208\186 \208\178\208\182\208\176\208\187 \208\184 \209\133\208\190\208\180\208\184\209\130", 
                [2] = "\208\181\208\177\208\176\208\189\208\176\209\130\208\176 \208\186\209\131\209\129\208\190\208\186"
            }, 
            [17] = {
                [1] = "\209\130\209\131\208\191\208\190\208\185 \209\133\209\131\208\181\209\129\208\190\209\129", 
                [2] = "", 
                [3] = "", 
                [4] = "\208\176 \209\130\208\181\208\191\208\181\209\128\209\140 \208\180\209\131\208\188\208\176\208\185, \209\141\209\130\208\190 \209\130\209\128\208\181\209\136\209\130\208\190\208\187\208\186 \208\191\208\184\209\136\208\181\209\130 \208\184\208\187\208\184 \209\143"
            }
        }
    }, 
    [3] = {
        on_kill = {
            [1] = "evalate.com/competition", 
            [2] = "Bruh, you aiming or praying?", 
            [3] = "Is your mouse broken or are you just that bad?", 
            [4] = "Choose your excuse: 1.Lags | 2.New mouse | 3.Low FPS | 4.Low team | 5.Hacker | 6.Lucker | 7.Smurf | 8.Hitbox | 9.Tickrate", 
            [5] = "ez", 
            [6] = "\240\157\146\149\240\157\146\150\240\157\146\147\240\157\146\143 \240\157\146\134\240\157\146\151\240\157\146\134\240\157\146\147\240\157\146\154 \240\157\146\142\240\157\146\130\240\157\146\149\240\157\146\132\240\157\146\137 \240\157\146\138\240\157\146\143\240\157\146\149\240\157\146\144 \240\157\146\154\240\157\146\144\240\157\146\150\240\157\146\147 \240\157\146\137\240\157\146\138\240\157\146\136\240\157\146\137\240\157\146\141\240\157\146\138\240\157\146\136\240\157\146\137\240\157\146\149 \240\157\146\147\240\157\146\134\240\157\146\134\240\157\146\141 \240\157\146\152\240\157\146\138\240\157\146\149\240\157\146\137 \240\157\146\134\240\157\146\151\240\157\146\130\240\157\146\141\240\157\146\130\240\157\146\149\240\157\146\134", 
            [7] = "\226\153\155 \240\157\144\142\240\157\144\150\240\157\144\141\240\157\144\132\240\157\144\131 \240\157\144\129\240\157\144\152 \240\157\144\132\240\157\144\149\240\157\144\128\240\157\144\139\240\157\144\128\240\157\144\147\240\157\144\132 \240\157\144\139\240\157\144\148\240\157\144\142 \226\153\155", 
            [8] = "bruh, your aim is like a potato on a spin cycle", 
            [9] = "you sure you're not playing with your feet?", 
            [10] = "are you lagging, or just naturally slow?", 
            [11] = "you aim like my grandma, and she's blind!"
        }, 
        on_death = {
            [1] = "mcdonalds resolver", 
            [2] = "i can't believe i can die"
        }
    }
};
local function v1315(v1313, v1314)
    utils.execute_after(v1313, function()
        -- upvalues: v1314 (ref)
        utils.console_exec("say " .. v1314);
    end);
end;
do
    local l_v1262_3, l_v1311_0, l_v1312_0, l_v1315_0 = v1262, v1311, v1312, v1315;
    local function v1324(v1320)
        -- upvalues: l_v1262_3 (ref), l_v1315_0 (ref)
        local l_l_v1262_3_0 = l_v1262_3;
        if type(v1320) == "string" then
            return l_v1315_0(l_l_v1262_3_0, v1320);
        else
            for _, v1323 in ipairs(v1320) do
                l_v1315_0(l_l_v1262_3_0, v1323);
                l_l_v1262_3_0 = l_l_v1262_3_0 + l_v1262_3;
            end;
            return;
        end;
    end;
    local function v1329(v1325)
        -- upvalues: l_v1312_0 (ref), l_v1311_0 (ref), v1324 (ref)
        local v1326 = l_v1312_0[l_v1311_0.style.value];
        if not v1326 then
            return;
        else
            local v1327 = v1326[v1325];
            if not v1327 or #v1327 < 1 then
                return;
            else
                local v1328 = v1327[utils.random_int(1, #v1327)];
                if not v1328 then
                    return;
                else
                    v1324(v1328);
                    return;
                end;
            end;
        end;
    end;
    l_v1311_0:set_event("player_death", function(v1330)
        -- upvalues: v265 (ref), l_v1311_0 (ref), v1329 (ref)
        local v1331 = entity.get(v1330.attacker, true);
        local v1332 = entity.get(v1330.userid, true);
        local l_me_16 = v265.me;
        if l_v1311_0.events:get("On Death") and v1331 ~= l_me_16 and v1332 == l_me_16 then
            v1329("on_death");
        end;
        if l_v1311_0.events:get("On Kill") and v1331 == l_me_16 and v1332 ~= l_me_16 then
            v1329("on_kill");
        end;
    end);
end;
v1262 = nil;
v1311 = v53.features.unlocks:switch("\v\f<link>    \rUnlock latency");
v51.new("unlock_latency", v1311, v70.features.misc);
v1311:tooltip("\v\f<circle-info>   \rUnlocks the Fake latency value and allows you to set the value higher.\n\n\v\f<folder>   \rMiscellaneous > Main > Other > Fake Latency");
v1312 = cvar.sv_maxunlag:float();
do
    local l_v1311_1, l_v1312_1, l_v1315_1 = v1311, v1312, v1315;
    l_v1315_1 = function()
        -- upvalues: l_v1312_1 (ref)
        cvar.sv_maxunlag:float(l_v1312_1);
    end;
    local function v1337()
        -- upvalues: l_v1311_1 (ref), l_v1315_1 (ref)
        if l_v1311_1:get() then
            cvar.sv_maxunlag:float(1);
        else
            l_v1315_1();
        end;
    end;
    l_v1311_1:set_event("shutdown", l_v1315_1);
    l_v1311_1:set_callback(v1337);
end;
v1311 = nil;
v1312 = v53.features.unlocks:switch("\v\f<rabbit>     \rUnlock fake duck speed");
v51.new("unlock_fake_duck_speed", v1312, v70.features.misc);
v1315 = 5;
do
    local l_v1315_2 = v1315;
    local function v1343(v1339)
        -- upvalues: v265 (ref), l_v1315_2 (ref)
        if not v265.is_alive then
            return;
        else
            local l_sidemove_0 = v1339.sidemove;
            local l_forwardmove_0 = v1339.forwardmove;
            if math.abs(l_forwardmove_0) > l_v1315_2 or math.abs(l_sidemove_0) > l_v1315_2 then
                local v1342 = 450 / (l_forwardmove_0 * l_forwardmove_0 + l_sidemove_0 * l_sidemove_0) ^ 0.5;
                v1339.forwardmove = l_forwardmove_0 * v1342;
                v1339.sidemove = l_sidemove_0 * v1342;
            end;
            return;
        end;
    end;
    local function v1345(v1344)
        -- upvalues: v1343 (ref)
        events.createmove_run(v1343, v1344.value);
    end;
    v1312:set_callback(function(v1346)
        -- upvalues: v52 (ref), v1345 (ref)
        if v1346.value then
            v52.fake_duck:set_callback(v1345);
        else
            v52.fake_duck:unset_callback(v1345);
        end;
    end);
end;
v1312 = {};
v1315 = ffi.typeof("        struct {\n            float x, y, z;\n        }\n    ");
local v1347 = ffi.typeof("        struct {\n            uint8_t r, g, b, a;\n        }\n    ");
local v1348 = utils.get_vfunc("engine.dll", "VDebugOverlay004", 1, ffi.typeof("void(__thiscall*)(void *thisptr, const $ &origin, const $ &mins, const $ &maxs, const $ &angles, int r, int g, int b, int a, float duration)", v1315, v1315, v1315, v1315));
local v1349 = utils.get_vfunc("engine.dll", "VDebugOverlay004", 20, ffi.typeof("void(__thiscall*)(void *thisptr, const $ &origin, const $ &dest, int r, int g, int b, int a, bool noDepthTest, float duration)", v1315, v1315));
local v1350 = utils.get_vfunc("engine.dll", "VDebugOverlay004", 21, "void(__thiscall*)(void *thisptr, const $ &origin, const $ &mins, const $ &maxs, const $ &angles, $ *face_color, $ *edge_color, float duration)", v1315, v1315, v1315, v1315, v1347, v1347);
do
    local l_v1315_3, l_v1347_0, l_v1348_0, l_v1349_0, l_v1350_0 = v1315, v1347, v1348, v1349, v1350;
    v1312.box = function(v1356, v1357, v1358, v1359, v1360, v1361, v1362, v1363, v1364)
        -- upvalues: l_v1315_3 (ref), l_v1348_0 (ref)
        v1356 = l_v1315_3(v1356:unpack());
        v1357 = l_v1315_3(v1357:unpack());
        v1358 = l_v1315_3(v1358:unpack());
        v1359 = l_v1315_3(v1359:unpack());
        l_v1348_0(v1356, v1357, v1358, v1359, v1360, v1361, v1362, v1363, v1364);
    end;
    v1312.line = function(v1365, v1366, v1367, v1368, v1369)
        -- upvalues: l_v1315_3 (ref), l_v1349_0 (ref)
        v1365 = l_v1315_3(v1365:unpack());
        v1366 = l_v1315_3(v1366:unpack());
        l_v1349_0(v1365, v1366, v1367.r, v1367.g, v1367.b, v1367.a, v1368, v1369);
    end;
    v1312.box_new = function(v1370, v1371, v1372, v1373, v1374, v1375, v1376)
        -- upvalues: l_v1315_3 (ref), l_v1347_0 (ref), l_v1350_0 (ref)
        v1370 = l_v1315_3(v1370:unpack());
        v1371 = l_v1315_3(v1371:unpack());
        v1372 = l_v1315_3(v1372:unpack());
        v1373 = l_v1315_3(v1373:unpack());
        v1374 = l_v1347_0(v1374:unpack());
        v1375 = l_v1347_0(v1375:unpack());
        l_v1350_0(v1370, v1371, v1372, v1373, v1374, v1375, v1376);
    end;
end;
v1315 = nil;
v1347 = v53.features.predict:switch("\v\f<sparkles>    \rPredict", false, "\v\f<circle-info>    \rAllows you to predict the player's position and shoot earlier.\n\n\v\f<user-gear>   \rStrength must be tested, as it varies for each player and depends on your pc and latency.", function(v1377, _)
    return {
        strength = v1377:list("\v\f<user-gear>   \rStrength", {
            [1] = "Soft", 
            [2] = "Medium", 
            [3] = "Extreme", 
            [4] = "Ultimate"
        })
    }, true;
end);
v51.new("predict", v1347, v70.features.aimbot);
v1348 = cvar.cl_interpolate;
v1349 = cvar.cl_interp_ratio;
v1350 = cvar.cl_interp;
do
    local l_v1347_1, l_v1348_1, l_v1349_1, l_v1350_1 = v1347, v1348, v1349, v1350;
    local function v1383()
        -- upvalues: l_v1348_1 (ref), l_v1349_1 (ref), l_v1350_1 (ref)
        l_v1348_1:int(1);
        l_v1349_1:int(2);
        l_v1350_1:float(0.015625);
    end;
    local function v1385()
        -- upvalues: l_v1347_1 (ref), l_v1348_1 (ref), l_v1349_1 (ref), l_v1350_1 (ref)
        local l_value_8 = l_v1347_1.strength.value;
        if l_value_8 == 1 then
            l_v1348_1:int(1);
            l_v1349_1:int(3);
            l_v1350_1:float(0.031);
        end;
        if l_value_8 == 2 then
            l_v1348_1:int(1);
            l_v1349_1:int(2);
            l_v1350_1:float(0.026);
        end;
        if l_value_8 == 3 then
            l_v1348_1:int(1);
            l_v1349_1:int(1);
            l_v1350_1:float(0.015625);
        end;
        if l_value_8 == 4 then
            l_v1348_1:int(0);
            l_v1349_1:int(1);
            l_v1350_1:float(0.015625);
        end;
    end;
    local function v1387(v1386)
        -- upvalues: v71 (ref), v1385 (ref), v72 (ref), v1383 (ref)
        if v1386.value then
            v71("createmove", v1385);
        else
            v72("createmove", v1385);
            v1383();
        end;
    end;
    events.shutdown(v1383);
    l_v1347_1:set_callback(v1387, true);
end;
v1347 = nil;
v1348 = v53.features.predict:switch("\v\f<person-walking-arrow-right>   \rAI Peek", false, nil, function(v1388, v1389)
    local v1391 = {
        simulation = v1388:slider("\v\f<timer>     \rSimulation", 25, 35, 30, nil, "ms"), 
        rate_limit = v1388:slider("\v\f<circle-pause>     \rProcess limit", 0, 30, 3, nil, function(v1390)
            if v1390 == 0 then
                return "Off";
            else
                return v1390 .. "ms";
            end;
        end), 
        hitboxes = v1388:selectable("\v\f<shield>     \rHitboxes", {
            [1] = "Head", 
            [2] = "Chest", 
            [3] = "Stomach", 
            [4] = "Arms", 
            [5] = "Legs"
        }), 
        weapons = v1388:selectable("\v\f<axe>    \rWeapons", {
            [1] = "Snipers", 
            [2] = "Pistols"
        }), 
        show_simulation = v1388:switch("\v\f<cube>     \rShow simulation", false, nil, {
            [1] = nil, 
            [2] = true, 
            [1] = color(255, 0, 0)
        })
    };
    v1389:tooltip("\v\f<circle-info>    \rRecommended to bind this switch to a same button as \vPeek Assist\r.");
    v1391.rate_limit:tooltip("\v\f<circle-info>    \rAllows you to limit the amount of processing and maintain performance.");
    return v1391;
end);
v51.new("ai_peek", v1348, v70.features.aimbot);
v1349 = bit.lshift(1, 0);
v1350 = 0;
local v1392 = 1;
local v1393 = 2;
local v1394 = 3;
local v1395 = 4;
local v1396 = 5;
local v1397 = 6;
local v1398 = 7;
local v1399 = 10;
local v1400 = 0;
local v1401 = 1;
local v1402 = 2;
local v1403 = 3;
local v1404 = 4;
local v1405 = 5;
local v1406 = 6;
local v1407 = 7;
local v1408 = 8;
local v1409 = 9;
local v1410 = 10;
local v1411 = 11;
local v1412 = 12;
local v1413 = 13;
local v1414 = 14;
local v1415 = 15;
local v1416 = 16;
local v1417 = 17;
local v1418 = 18;
local v1419 = {
    [v1400] = v1392, 
    [v1405] = v1393, 
    [v1403] = v1394, 
    [v1408] = v1397, 
    [v1407] = v1398, 
    [v1412] = v1397, 
    [v1411] = v1398, 
    [v1417] = v1395, 
    [v1415] = v1396
};
local v1420 = nil;
local v1421 = 0;
local v1422 = nil;
do
    local l_v1348_2, l_v1349_2, l_v1350_2, l_v1392_0, l_v1394_0, l_v1397_0, l_v1398_0, l_v1400_0, l_v1403_0, l_v1405_0, l_v1407_0, l_v1408_0, l_v1409_0, l_v1410_0, l_v1415_0, l_v1417_0, l_v1419_0, l_v1420_0, l_v1421_0, l_v1422_0 = v1348, v1349, v1350, v1392, v1394, v1397, v1398, v1400, v1403, v1405, v1407, v1408, v1409, v1410, v1415, v1417, v1419, v1420, v1421, v1422;
    local function v1443()
        -- upvalues: l_v1420_0 (ref), l_v1421_0 (ref)
        l_v1420_0 = nil;
        l_v1421_0 = 0;
    end;
    local function v1444()
        -- upvalues: v52 (ref)
        v52.double_tap:override();
        v52.peek_assist.retreat_mode:override();
    end;
    local function v1445()
        -- upvalues: v52 (ref)
        v52.peek_assist.retreat_mode:override("On Shot");
    end;
    local function v1447(v1446)
        -- upvalues: l_v1392_0 (ref), l_v1394_0 (ref), l_v1397_0 (ref), l_v1398_0 (ref)
        if v1446 == l_v1392_0 then
            return 4;
        elseif v1446 == l_v1394_0 then
            return 1.25;
        elseif v1446 == l_v1397_0 then
            return 0.75;
        elseif v1446 == l_v1398_0 then
            return 0.75;
        else
            return 1;
        end;
    end;
    local function v1452(v1448, v1449, v1450, v1451)
        -- upvalues: v1447 (ref), l_v1392_0 (ref)
        v1449 = v1449 * v1447(v1450);
        if v1448.m_ArmorValue > 0 then
            if v1450 == l_v1392_0 then
                if v1448.m_bHasHelmet then
                    v1449 = v1449 * (v1451 * 0.5);
                end;
            else
                v1449 = v1449 * (v1451 * 0.5);
            end;
        end;
        return v1449;
    end;
    local function v1464(v1453, v1454, v1455, v1456, v1457)
        -- upvalues: v1452 (ref)
        local v1458 = v1454 - v1453;
        local l_damage_1 = v1457.damage;
        local l_armor_ratio_0 = v1457.armor_ratio;
        local l_range_0 = v1457.range;
        local l_range_modifier_0 = v1457.range_modifier;
        local v1463 = math.min(l_range_0, v1458:length());
        l_damage_1 = l_damage_1 * math.pow(l_range_modifier_0, v1463 * 0.002);
        return (v1452(v1455, l_damage_1, v1456, l_armor_ratio_0));
    end;
    local function v1465()
        -- upvalues: l_v1348_2 (ref)
        return l_v1348_2.simulation:get() * 0.01;
    end;
    local function v1466()
        -- upvalues: l_v1348_2 (ref)
        return l_v1348_2.rate_limit:get() * 0.01;
    end;
    local function v1467()
        -- upvalues: v52 (ref)
        return v52.damage:get();
    end;
    local function v1470(v1468)
        -- upvalues: l_v1349_2 (ref)
        if v1468 == nil then
            return;
        else
            local v1469 = v1468:get_origin();
            if bit.band(v1468.m_fFlags, l_v1349_2) == 0 then
                return utils.trace_line(v1469, v1469 - vector(0, 0, 8192), v1468, 33636363).end_pos;
            else
                return v1469;
            end;
        end;
    end;
    local function v1472()
        -- upvalues: l_v1348_2 (ref), l_v1400_0 (ref), l_v1405_0 (ref), l_v1403_0 (ref), l_v1417_0 (ref), l_v1415_0 (ref), l_v1408_0 (ref), l_v1407_0 (ref), l_v1410_0 (ref), l_v1409_0 (ref)
        local v1471 = {};
        if l_v1348_2.hitboxes:get("Head") then
            table.insert(v1471, l_v1400_0);
        end;
        if l_v1348_2.hitboxes:get("Chest") then
            table.insert(v1471, l_v1405_0);
        end;
        if l_v1348_2.hitboxes:get("Stomach") then
            table.insert(v1471, l_v1403_0);
        end;
        if l_v1348_2.hitboxes:get("Arms") then
            table.insert(v1471, l_v1417_0);
            table.insert(v1471, l_v1415_0);
        end;
        if l_v1348_2.hitboxes:get("Legs") then
            table.insert(v1471, l_v1408_0);
            table.insert(v1471, l_v1407_0);
            table.insert(v1471, l_v1410_0);
            table.insert(v1471, l_v1409_0);
        end;
        return v1471;
    end;
    local function v1474(v1473)
        -- upvalues: l_v1419_0 (ref), l_v1350_2 (ref)
        return l_v1419_0[v1473] or l_v1350_2;
    end;
    local function v1479(v1475, v1476)
        local _ = v1475:get_weapon_index();
        local l_weapon_type_0 = v1476.weapon_type;
        if l_weapon_type_0 == 1 then
            return "Pistols";
        elseif l_weapon_type_0 == 5 then
            return "Snipers";
        else
            return nil;
        end;
    end;
    local function v1496(v1480, v1481, v1482, v1483, v1484)
        -- upvalues: v1474 (ref), v1464 (ref)
        local v1485 = {};
        local v1486 = v1481:get_eye_position();
        local v1487 = v1482:get_weapon_info();
        local l_m_iHealth_1 = v1483.m_iHealth;
        for v1489 = 1, #v1480 do
            local v1490 = v1480[v1489];
            local v1491 = v1474(v1490);
            local v1492 = v1483:get_hitbox_position(v1490);
            local v1493 = v1464(v1486, v1492, v1483, v1491, v1487);
            local v1494 = v1493 < v1484;
            local v1495 = v1493 < l_m_iHealth_1;
            if not v1494 or not v1495 then
                table.insert(v1485, {
                    index = v1489, 
                    pos = v1492
                });
            end;
        end;
        return v1485;
    end;
    local function v1498(v1497)
        -- upvalues: v230 (ref)
        return v230(v1497.target);
    end;
    local function v1500(v1499)
        return not v1499.in_forward and not v1499.in_back and not v1499.in_moveleft and not v1499.in_moveright;
    end;
    local function v1502(v1501)
        -- upvalues: l_v1348_2 (ref)
        return l_v1348_2.weapons:get(v1501);
    end;
    local function v1507(v1503, v1504, v1505)
        if v1503 == nil or v1504 == nil then
            return false;
        elseif v1505.max_clip1 == 0 or v1504.m_iClip1 == 0 then
            return false;
        else
            local l_curtime_0 = globals.curtime;
            if l_curtime_0 < v1503.m_flNextAttack then
                return false;
            elseif l_curtime_0 < v1504.m_flNextPrimaryAttack then
                return false;
            else
                return true;
            end;
        end;
    end;
    local function v1508()
        -- upvalues: v265 (ref)
        if not v265.is_double_tap then
            return false;
        else
            return true;
        end;
    end;
    local function v1511(v1509, v1510)
        return {
            ctx = v1509, 
            target = v1510, 
            simtime = 0, 
            retreat = -1
        };
    end;
    local function v1513(v1512)
        return v1512:simulate_movement(nil, vector(), 1);
    end;
    local function v1520(v1514, v1515, v1516)
        local v1518, v1519 = utils.trace_bullet(v1514, v1515, v1516, function(v1517)
            -- upvalues: v1514 (ref)
            return v1517 ~= v1514 and v1517:is_enemy();
        end);
        return v1518, v1519;
    end;
    local function v1534(v1521, v1522, v1523, v1524, v1525)
        -- upvalues: v1520 (ref)
        local l_m_iHealth_2 = v1523.m_iHealth;
        local v1527 = v1521.origin + vector(0, 0, v1521.view_offset);
        for v1528 = 1, #v1524 do
            local v1529 = v1524[v1528];
            local v1530, _ = v1520(v1522, v1527, v1529.pos);
            local v1532 = v1525 <= v1530;
            local v1533 = l_m_iHealth_2 <= v1530;
            if v1532 or v1533 then
                return v1521, true;
            end;
        end;
        return v1521, false;
    end;
    local function v1537(v1535)
        -- upvalues: l_v1422_0 (ref), v1470 (ref)
        local v1536 = entity.get_local_player();
        if not v1536 or v1536 == nil then
            return;
        else
            if not v1535 or v1535 == nil then
                v1535 = v1536;
            end;
            if l_v1422_0 == nil then
                l_v1422_0 = v1470(v1535);
            end;
            return;
        end;
    end;
    local function v1547(v1538, v1539, v1540, v1541, v1542, v1543, v1544)
        -- upvalues: l_v1349_2 (ref), v1534 (ref)
        v1538.view_angles.y = v1542;
        v1541:think(1);
        if bit.band(v1541.flags, l_v1349_2) == 0 then
            return nil, false;
        else
            local _, v1546 = v1534(v1541, v1539, v1540, v1543, v1544);
            if v1546 then
                v1541:think(1);
            end;
            return v1541, v1546;
        end;
    end;
    local function v1582(v1548, v1549, v1550)
        -- upvalues: v1508 (ref), v1466 (ref), v1467 (ref), v1472 (ref), l_v1420_0 (ref), v1498 (ref), v1496 (ref), v1534 (ref), l_v1421_0 (ref), v1500 (ref), l_v1349_2 (ref), v1513 (ref), v1547 (ref), v1511 (ref)
        if not v1508() then
            return false;
        else
            local l_frametime_0 = globals.frametime;
            local v1552 = v1466();
            local v1553 = v1467();
            local v1554 = v1472();
            if l_v1420_0 ~= nil and v1498(l_v1420_0) then
                local l_ctx_0 = l_v1420_0.ctx;
                local l_target_1 = l_v1420_0.target;
                local l_m_iHealth_3 = l_target_1.m_iHealth;
                if v1553 >= 100 then
                    v1553 = v1553 + l_m_iHealth_3 - 100;
                end;
                local v1558 = v1496(v1554, v1549, v1550, l_target_1, v1553);
                local _, v1560 = v1534(l_ctx_0, v1549, l_target_1, v1558, v1553);
                if v1560 then
                    l_v1420_0.simtime = 0;
                end;
                l_v1420_0.simtime = l_v1420_0.simtime + l_frametime_0;
                return true;
            else
                if v1552 > 0 then
                    if l_v1421_0 > 0 then
                        l_v1421_0 = l_v1421_0 - l_frametime_0;
                        return false;
                    else
                        l_v1421_0 = v1552;
                    end;
                end;
                if not v1500(v1548) then
                    return false;
                else
                    local l_m_fFlags_0 = v1549.m_fFlags;
                    if bit.band(l_m_fFlags_0, l_v1349_2) == 0 then
                        return false;
                    elseif v1549.m_vecVelocity:length2dsqr() > 6400 then
                        return false;
                    else
                        local v1562 = entity.get_threat();
                        if v1562 == nil or v1562:is_dormant() then
                            return false;
                        else
                            local l_m_iHealth_4 = v1562.m_iHealth;
                            if v1553 >= 100 then
                                v1553 = v1553 + l_m_iHealth_4 - 100;
                            end;
                            local v1564 = v1496(v1554, v1549, v1550, v1562, v1553);
                            local v1565 = nil;
                            local v1566 = nil;
                            local v1567 = v1549:get_origin();
                            local v1568 = (v1562:get_origin() - v1567):angles().y + 180;
                            v1565 = v1568 - 90;
                            v1566 = v1568 + 90;
                            v1567 = v1548.view_angles:clone();
                            local l_forwardmove_1 = v1548.forwardmove;
                            local l_sidemove_1 = v1548.sidemove;
                            local l_in_duck_0 = v1548.in_duck;
                            v1568 = v1548.in_jump;
                            local l_in_speed_0 = v1548.in_speed;
                            v1548.forwardmove = 450;
                            v1548.sidemove = 0;
                            v1548.in_duck = false;
                            v1548.in_jump = false;
                            v1548.in_speed = false;
                            local v1573 = v1513(v1549);
                            local v1574 = v1513(v1549);
                            local v1575 = 0;
                            local v1576 = 0;
                            for v1577 = 1, 20 do
                                if v1575 ~= -1 then
                                    v1575 = v1577;
                                    local v1578, v1579 = v1547(v1548, v1549, v1562, v1573, v1565, v1564, v1553);
                                    if v1578 == nil then
                                        v1575 = -1;
                                    end;
                                    if v1579 then
                                        l_v1420_0 = v1511(v1578, v1562);
                                        break;
                                    end;
                                end;
                                if v1576 ~= -1 then
                                    v1576 = v1577;
                                    local v1580, v1581 = v1547(v1548, v1549, v1562, v1574, v1566, v1564, v1553);
                                    if v1580 == nil then
                                        v1576 = -1;
                                    end;
                                    if v1581 then
                                        l_v1420_0 = v1511(v1580, v1562);
                                        break;
                                    end;
                                end;
                            end;
                            v1548.view_angles.y = v1567.y;
                            v1548.forwardmove = l_forwardmove_1;
                            v1548.sidemove = l_sidemove_1;
                            v1548.in_duck = l_in_duck_0;
                            v1548.in_jump = v1568;
                            v1548.in_speed = l_in_speed_0;
                            return l_v1420_0 ~= nil;
                        end;
                    end;
                end;
            end;
        end;
    end;
    local function v1590(v1583, v1584, v1585)
        local v1586 = v1585 - v1584:get_origin();
        local v1587 = v1586:length2dsqr();
        if v1587 < 25 then
            local l_m_vecVelocity_0 = v1584.m_vecVelocity;
            local v1589 = l_m_vecVelocity_0:length();
            v1583.move_yaw = l_m_vecVelocity_0:angles().y;
            v1583.forwardmove = -v1589;
            v1583.sidemove = 0;
            return true, v1587;
        else
            v1583.move_yaw = v1586:angles().y;
            v1583.forwardmove = 450;
            v1583.sidemove = 0;
            return false, v1587;
        end;
    end;
    local function v1592(v1591)
        v1591.in_duck = false;
        v1591.in_jump = false;
        v1591.in_speed = false;
        v1591.in_forward = true;
        v1591.in_back = false;
        v1591.in_moveleft = false;
        v1591.in_moveright = false;
    end;
    local function v1604(v1593, v1594, v1595, v1596)
        -- upvalues: v1537 (ref), v1507 (ref), v1582 (ref), l_v1420_0 (ref), v1465 (ref), v1590 (ref), v1592 (ref), v1445 (ref), l_v1348_2 (ref), v1312 (ref), l_v1422_0 (ref), v52 (ref), v1443 (ref), v1444 (ref)
        v1537(v1594);
        local v1597 = v1507(v1594, v1595, v1596);
        local v1598 = v1582(v1593, v1594, v1595);
        if l_v1420_0 == nil then
            return;
        else
            if v1465() < l_v1420_0.simtime then
                v1598 = false;
            end;
            if v1596.weapon_type == 5 and not v1594.m_bIsScoped then
                v1598 = false;
            end;
            if l_v1420_0.retreat <= 0 and v1597 and v1598 then
                local l_ctx_1 = l_v1420_0.ctx;
                local v1600, _ = v1590(v1593, v1594, l_ctx_1.origin);
                v1592(v1593);
                v1445();
                l_v1420_0.retreat = 0;
                if v1600 then
                    l_v1420_0.retreat = 1;
                end;
                if l_v1348_2.show_simulation.value then
                    v1312.box_new(l_ctx_1.origin, l_ctx_1.obb_mins, l_ctx_1.obb_maxs, vector(), color(0, 0, 0, 0), l_v1348_2.show_simulation.color.value, globals.tickinterval * 2);
                end;
                return;
            elseif l_v1420_0.retreat == -1 then
                return;
            else
                local v1602, _ = v1590(v1593, v1594, l_v1422_0);
                v1592(v1593);
                l_v1420_0.retreat = l_v1420_0.retreat + 1;
                if l_v1420_0.retreat >= 3 then
                    v52.double_tap:override(false);
                end;
                if v1597 and v1602 then
                    v1443();
                    v1444();
                end;
                return;
            end;
        end;
    end;
    local function v1610(v1605)
        -- upvalues: v1479 (ref), v1502 (ref), v1604 (ref)
        local v1606 = entity.get_local_player();
        if v1606 == nil then
            return;
        else
            local v1607 = v1606:get_player_weapon();
            if v1607 == nil then
                return;
            else
                local v1608 = v1607:get_weapon_info();
                if v1608 == nil then
                    return;
                else
                    local v1609 = v1479(v1607, v1608);
                    if not v1502(v1609) then
                        return;
                    else
                        v1604(v1605, v1606, v1607, v1608);
                        return;
                    end;
                end;
            end;
        end;
    end;
    local function v1611()
        -- upvalues: l_v1420_0 (ref)
        if l_v1420_0 == nil then
            return nil;
        else
            l_v1420_0.retreat = 1;
            return;
        end;
    end;
    l_v1348_2:set_callback(function(v1612)
        -- upvalues: v1443 (ref), v1444 (ref), l_v1422_0 (ref), v1537 (ref), v1611 (ref), v1610 (ref)
        local v1613 = v1612:get();
        if not v1613 then
            v1443();
            v1444();
            l_v1422_0 = nil;
        end;
        if v1613 then
            l_v1422_0 = v1537();
        end;
        events.aim_fire(v1611, v1613);
        events.createmove(v1610, v1613);
    end, true);
end;
v1348 = true;
v1349 = nil;
v1350 = v53.features.predict:switch("\v\f<person-ski-jumping>    \rJump scout", false, "\v\f<circle-info>    \rAllows you to jump in place without moving. Also works with a revolver.");
v51.new("jump_scout", v1350, v70.features.aimbot);
v1392 = false;
do
    local l_v1392_1, l_v1393_0 = v1392, v1393;
    l_v1393_0 = function()
        -- upvalues: l_v1392_1 (ref), v1348 (ref), v52 (ref)
        if l_v1392_1 then
            l_v1392_1 = false;
            v1348 = true;
            v52.air_strafe:override();
            v52.auto_stop.options:override();
        end;
    end;
    v1350:set_event("createmove", function(v1616)
        -- upvalues: v1348 (ref), l_v1393_0 (ref), v265 (ref), l_v1392_1 (ref), v52 (ref)
        if not v1348 then
            l_v1393_0();
        end;
        local l_velocity_1 = v265.velocity;
        local l_anim_state_1 = v265.anim_state;
        local l_weapon_info_3 = v265.weapon_info;
        if not l_anim_state_1 or not l_weapon_info_3 or not l_velocity_1 then
            return;
        else
            local l_console_name_0 = l_weapon_info_3.console_name;
            if l_console_name_0 ~= "weapon_ssg08" and l_console_name_0 ~= "weapon_revolver" then
                return;
            elseif v1616.in_moveleft or v1616.in_moveright or v1616.in_forward or v1616.in_back or v1616.in_left or v1616.in_right then
                return;
            elseif v1616.forwardmove + v1616.sidemove > 0 then
                return;
            elseif l_anim_state_1.on_ground and not v1616.in_jump then
                return;
            elseif l_velocity_1 > 1.2 then
                return;
            else
                l_v1392_1 = true;
                v1348 = false;
                v52.air_strafe:override(false);
                v52.auto_stop.options:override({
                    [1] = "In Air"
                });
                return;
            end;
        end;
    end);
    v1350:set_callback(function(v1621)
        -- upvalues: l_v1393_0 (ref)
        if not v1621.value then
            l_v1393_0();
        end;
    end);
end;
v1350 = nil;
v1392 = v53.features.air:switch("\v\f<tower-broadcast>    \rAir exploit", false, nil, function(v1622, _)
    return {
        ticks = v1622:slider("\v\f<clock-rotate-left>      \rDuration", 5, 40, 10, 1, "t")
    }, true;
end);
v51.new("air_exploit", v1392, v70.features.aimbot);
v1393 = function()
    -- upvalues: v52 (ref)
    v52.double_tap.lag_limit:override();
end;
do
    local l_v1392_2, l_v1393_1 = v1392, v1393;
    l_v1392_2:set_event("createmove", function(v1626)
        -- upvalues: v265 (ref), l_v1393_1 (ref), l_v1392_2 (ref), v52 (ref)
        local l_anim_state_2 = v265.anim_state;
        local l_weapon_info_4 = v265.weapon_info;
        if not l_anim_state_2 or not l_weapon_info_4 then
            return l_v1393_1();
        elseif l_anim_state_2.on_ground and not v1626.in_jump then
            return l_v1393_1();
        elseif l_weapon_info_4.weapon_type == 9 then
            return l_v1393_1();
        else
            if v265.exploit_charge == 1 and globals.tickcount % l_v1392_2.ticks.value == 0 then
                v1626.force_defensive = true;
                v52.double_tap.lag_limit:override(math.random(7));
                rage.exploit:force_teleport();
            else
                rage.exploit:force_charge();
            end;
            return;
        end;
    end);
    l_v1392_2:set_callback(function(v1629)
        -- upvalues: l_v1393_1 (ref)
        if not v1629.value then
            l_v1393_1();
        end;
    end);
end;
v1392 = nil;
v1393 = v53.features.air:switch("\v\f<person-from-portal>     \rAir teleport", false, "\v\f<circle-info>    \rJump out with teleportation onto your opponents.", function(v1630, _)
    return {
        allow_on_cross = v1630:switch("\v\f<person-running>    \rAllow on cross"), 
        weapons = v1630:listable("\v\f<shield>    \rWeapons", {
            [1] = "Awp", 
            [2] = "Scout", 
            [3] = "Taser"
        })
    }, true;
end);
v51.new("air_teleport", v1393, v70.features.aimbot);
v1394 = {
    [9] = 1, 
    [40] = 2, 
    [31] = 3
};
do
    local l_v1393_2, l_v1394_1 = v1393, v1394;
    l_v1393_2:set_event("createmove", function(v1634)
        -- upvalues: v1348 (ref), v265 (ref), l_v1393_2 (ref), l_v1394_1 (ref)
        if not v1348 then
            return;
        else
            local l_me_17 = v265.me;
            local l_eye_1 = v265.eye;
            local l_weapon_4 = v265.weapon;
            local l_players_2 = v265.players;
            local l_is_alive_0 = v265.is_alive;
            local l_anim_state_3 = v265.anim_state;
            local _ = v265.is_double_tap;
            local _ = v265.exploit_charge;
            if not l_me_17 or not l_eye_1 or not l_weapon_4 or not l_is_alive_0 or not l_anim_state_3 or l_anim_state_3.on_ground or #l_players_2 <= 0 then
                return;
            elseif not v265.is_double_tap or v265.exploit_charge ~= 1 then
                return;
            elseif v1634.in_jump and not l_v1393_2.allow_on_cross.value then
                return;
            else
                local v1643 = l_weapon_4:get_weapon_index();
                if not v1643 then
                    return;
                else
                    local v1644 = l_v1394_1[v1643];
                    if not v1644 then
                        return;
                    elseif not l_v1393_2.weapons:get(v1644) then
                        return;
                    else
                        local v1645 = l_me_17:simulate_movement();
                        v1645:think(6);
                        local v1646 = vector(v1645.origin.x, v1645.origin.y, l_eye_1.z);
                        local v1647 = false;
                        for _, v1649 in ipairs(l_players_2) do
                            if v1649.is_enemy and v1649.is_alive and not v1649.is_dormant then
                                local v1650 = v1649.entity:get_hitbox_position(3);
                                local v1651, v1652 = utils.trace_bullet(l_me_17, v1646, v1650);
                                if v1651 > 10 and v1652.entity and v1652.entity == v1649.entity then
                                    v1647 = true;
                                    break;
                                end;
                            end;
                        end;
                        if v1647 then
                            rage.exploit:force_teleport();
                        end;
                        return;
                    end;
                end;
            end;
        end;
    end);
end;
v1393 = nil;
v1394 = {
    data = {}, 
    names = {}, 
    new = function(v1653, v1654, v1655)
        v1653.data[v1654] = v1655;
        table.insert(v1653.names, v1654);
    end
};
v1394:new("Stand", function(v1656, _, v1658, v1659)
    return v1658.on_ground and v1659 < 2 and not v1656.in_duck and not v1656.in_jump;
end);
v1394:new("Crouch", function(v1660, _, v1662, _)
    return v1662.on_ground and v1660.in_duck and not v1660.in_jump;
end);
v1394:new("Slow walk", function(v1664, _, _, _)
    -- upvalues: v265 (ref)
    return v265.is_slow_walk and not v1664.in_jump;
end);
v1395 = {
    data = {}, 
    names = {}, 
    new = function(v1668, v1669, v1670)
        v1668.data[v1669] = v1670;
        table.insert(v1668.names, v1669);
    end
};
v1395:new("Pistols", function(v1671, v1672, _, _, _, _)
    return v1672.weapon_type == 1 and v1671 ~= "CDEagle";
end);
v1395:new("Desert Eagle", function(v1677, _, v1679, _, v1681, _)
    return v1677 == "CDEagle" and (not v1681.on_ground or not v1679.in_duck);
end);
v1395:new("Auto Snipers", function(v1683, _, _, _, _, _)
    return v1683 == "CWeaponSCAR20" or v1683 == "CWeaponG3SG1";
end);
v1395:new("Desert Eagle & Crouch", function(v1689, _, v1691, _, v1693, _)
    return v1689 == "CDEagle" and v1693.on_ground and v1691.in_duck;
end);
do
    local l_v1394_2, l_v1395_0, l_v1396_0, l_v1397_1 = v1394, v1395, v1396, v1397;
    l_v1396_0 = v53.features.premium:switch("\v\f<shield>    \rAuto OS", false, nil, function(v1699, v1700)
        -- upvalues: l_v1394_2 (ref), l_v1395_0 (ref)
        local v1701 = {
            states = v1699:listable("\v\f<wave-pulse>   \rStates", l_v1394_2.names), 
            avoid_states = v1699:listable("\v\f<arrow-rotate-right>   \rAvoid", l_v1395_0.names)
        };
        v1700:tooltip("\v\f<circle-info>   \rEnables hide shots in certain situations with double tap.");
        v1701.avoid_states:tooltip("\v\f<circle-info>   \rSelect a state from the list that you would not want the function to work with.\n\n\v\f<lightbulb>   \rFor example, if you select \vPistols\r, then \vAuto OS\r will not work if you are holding a pistol.");
        v1701.avoid_states:depend({
            [1] = v1701.states, 
            [2] = function()
                -- upvalues: v1701 (ref)
                return #v1701.states.value > 0;
            end
        });
        return v1701, true;
    end);
    v51.new("auto_hide_shots", l_v1396_0, v70.features.aimbot);
    l_v1395_0.get_active = function(v1702, v1703, v1704, v1705, v1706, v1707, v1708)
        -- upvalues: l_v1396_0 (ref)
        if v1704.is_revolver then
            return true;
        else
            for v1709, v1710 in ipairs(v1702.names) do
                local v1711 = v1702.data[v1710];
                if l_v1396_0.avoid_states:get(v1709) and v1711 and v1711(v1703, v1704, v1705, v1706, v1707, v1708) then
                    return true;
                end;
            end;
            return false;
        end;
    end;
    l_v1394_2.get_active = function(v1712, v1713, v1714, v1715, v1716)
        -- upvalues: l_v1396_0 (ref)
        for v1717, v1718 in ipairs(v1712.names) do
            local v1719 = v1712.data[v1718];
            if l_v1396_0.states:get(v1717) and v1719 and v1719(v1713, v1714, v1715, v1716) then
                return true;
            end;
        end;
        return false;
    end;
    l_v1397_1 = function()
        -- upvalues: v52 (ref)
        v52.hide_shots:override();
        v52.double_tap:override();
    end;
    v1398 = function(v1720)
        -- upvalues: v265 (ref), v52 (ref), l_v1394_2 (ref), l_v1395_0 (ref), l_v1397_1 (ref)
        local l_me_18 = v265.me;
        local l_weapon_5 = v265.weapon;
        local l_weapon_info_5 = v265.weapon_info;
        local l_anim_state_4 = v265.anim_state;
        if not l_me_18 or not l_weapon_5 or not l_weapon_info_5 or not l_anim_state_4 then
            return;
        else
            local v1725 = l_weapon_5:get_classname();
            local v1726 = l_anim_state_4.velocity:length();
            if v52.double_tap:get() and not v52.hide_shots:get() and v265.exploit_charge == 1 and not v52.peek_assist:get_override() and not v52.peek_assist:get() and l_v1394_2:get_active(v1720, l_me_18, l_anim_state_4, v1726) and not l_v1395_0:get_active(v1725, l_weapon_info_5, v1720, l_me_18, l_anim_state_4, v1726) then
                v52.hide_shots:override(true);
                v52.double_tap:override(false);
                return;
            else
                l_v1397_1();
                return;
            end;
        end;
    end;
    l_v1396_0:set_callback(l_v1397_1);
    l_v1396_0:set_event("createmove", v1398);
end;
v1394 = nil;
v1395 = v53.features.premium:switch("\v\f<syringe>    \rDormant aimbot", false, nil, function(v1727)
    return {
        min_damage = v1727:slider("\v\f<angle>    \rDamage", 0, 100, 20), 
        min_inaccuracy = v1727:slider(" \v\f<person-walking>     \rInaccuracy", 0, 100, 80)
    };
end);
v51.new("dormant_aimbot", v1395, v70.features.aimbot);
v1396 = function(v1728, v1729)
    local v1730 = math.sqrt(v1728.forwardmove * v1728.forwardmove + v1728.sidemove * v1728.sidemove);
    if v1729 <= 0 or v1730 <= 0 then
        return;
    else
        if v1728.in_duck then
            v1729 = v1729 * 2.94117647;
        end;
        if v1730 <= v1729 then
            return;
        else
            local v1731 = v1729 / v1730;
            v1728.forwardmove = v1728.forwardmove * v1731;
            v1728.sidemove = v1728.sidemove * v1731;
            return;
        end;
    end;
end;
v1397 = {
    [1] = "100% info", 
    [2] = "updated by shared esp", 
    [3] = "updated by sounds", 
    [4] = "not updated", 
    [5] = "data is unavailable or too old"
};
do
    local l_v1395_1, l_v1396_1, l_v1397_2, l_v1398_1 = v1395, v1396, v1397, v1398;
    l_v1398_1 = function(v1736)
        -- upvalues: v265 (ref), l_v1395_1 (ref), l_v1397_2 (ref)
        local v1737 = nil;
        local l_eye_2 = v265.eye;
        for _, v1740 in ipairs(v265.players) do
            if v1740.is_alive and v1740.is_dormant and v1740.is_enemy then
                local l_entity_4 = v1740.entity;
                local v1742 = l_entity_4:get_bbox();
                local v1743 = l_entity_4:get_network_state();
                if v1743 ~= 0 and v1742.alpha > 0 then
                    local v1744 = l_entity_4:get_origin() + vector(0, 0, 35) + vector(utils.random_float(-7, 7), utils.random_float(-7, 7), utils.random_float(-10, 25));
                    local v1746, _ = utils.trace_bullet(v1736, l_eye_2, v1744, function(v1745)
                        return v1745:is_player() and v1745:is_enemy();
                    end);
                    if l_v1395_1.min_damage.value <= v1746 then
                        v1737 = {
                            entity = l_entity_4, 
                            damage = v1746, 
                            angles = l_eye_2:to(v1744):angles(), 
                            network_state = l_v1397_2[v1743] or v1743
                        };
                    end;
                end;
            end;
        end;
        return v1737;
    end;
    l_v1395_1:set_event("createmove", function(v1748)
        -- upvalues: v265 (ref), l_v1398_1 (ref), l_v1396_1 (ref), l_v1395_1 (ref)
        local l_me_19 = v265.me;
        local l_weapon_6 = v265.weapon;
        local l_weapon_info_6 = v265.weapon_info;
        if not l_me_19 or not v265.is_alive or not l_weapon_6 or not l_weapon_info_6 then
            return;
        elseif not v265.anim_state.on_ground or v1748.in_jump then
            return;
        elseif l_weapon_info_6.bullets < 1 then
            return;
        else
            local l_curtime_1 = globals.curtime;
            local v1753 = l_weapon_info_6.weapon_type == 5;
            local v1754 = math.clamp(1 / l_weapon_6:get_inaccuracy(), 0, 666);
            local v1755 = false;
            if v1753 or l_weapon_info_6.is_revolver then
                v1755 = l_curtime_1 + 0.3 > l_me_19.m_flNextAttack and l_curtime_1 + 0.3 > l_weapon_6.m_flNextPrimaryAttack;
            end;
            if not v1755 then
                return;
            else
                local v1756 = l_v1398_1(l_me_19);
                if not v1756 then
                    return;
                else
                    if v1753 and not l_me_19.m_bIsScoped then
                        v1748.in_attack2 = true;
                    end;
                    local v1757 = l_me_19.m_bIsScoped and l_weapon_info_6.max_player_speed_alt or l_weapon_info_6.max_player_speed;
                    l_v1396_1(v1748, v1757 * 0.1);
                    if v1754 < l_v1395_1.min_inaccuracy.value then
                        return;
                    else
                        local v1758 = l_me_19.m_aimPunchAngle * cvar.weapon_recoil_scale:float();
                        v1748.view_angles = v1756.angles - v1758;
                        v1748.in_attack = true;
                        return;
                    end;
                end;
            end;
        end;
    end);
end;
v1395 = nil;
v1396 = false;
v1397 = {};
v1398 = {};
v1399 = {};
v1400 = v53.antiaim.main.par:name();
v1401 = 3;
v1402 = 8;
v1403 = "Global";
v1404 = {
    [1] = nil, 
    [2] = "Stand", 
    [3] = "Run", 
    [4] = "Walk", 
    [5] = "Crouch", 
    [6] = "Creeping", 
    [7] = "Air", 
    [8] = "Air crouch", 
    [9] = "On use", 
    [1] = v1403
};
v1405 = {
    [1] = "Stand", 
    [2] = "Run", 
    [3] = "Walk", 
    [4] = "Crouch", 
    [5] = "Creeping", 
    [6] = "Air", 
    [7] = "Air crouch", 
    [8] = "On peek"
};
v1406 = {
    [1] = "Terrorists", 
    [2] = "Counter-Terrorists"
};
v1407 = {
    ["Counter-Terrorists"] = "CT", 
    Terrorists = "T"
};
v1408 = {
    [1] = "Base", 
    [2] = "Terrorists", 
    [3] = "Counter-Terrorists"
};
v1409 = {
    Right = 90, 
    Forward = 180, 
    Left = -90
};
v1397.unmatched_features = v53.antiaim.enable:label("\v\f<trophy>    \rUnmatched features", nil, function(v1759)
    return {
        disable_defensive = v1759:switch("\v\f<solar-system>    \rDisable defensive"), 
        warmup_fake_duck = v1759:switch("\v\f<duck>    \rFake duck on warmup")
    };
end);
v1397.unmatched_features:depend(v70.antiaim.setup);
v1397.fake_flick = v53.antiaim.setup:switch("\v\f<arrows-turn-right>     \rFake flick"):depend(v70.antiaim.setup);
v1397.fake_flick:disabled(true);
v1397.allow_on_use = v53.antiaim.setup:switch("\v\f<flag-swallowtail>     \rAllow on use"):depend(v70.antiaim.setup);
v1397.avoid_backstab = v53.antiaim.setup:switch("\v\f<knife-kitchen>    \rAvoid backstab"):depend(v70.antiaim.setup);
v1397.safe_head = v53.antiaim.setup_two:switch("\v\f<shield-check>     \rSafe head", false, nil, function(v1760)
    return {
        states = v1760:listable(" \v\f<person-walking>     \rStates", {
            [1] = "Air", 
            [2] = "Stand", 
            [3] = "Crouch"
        }), 
        options = v1760:listable("\a[grey]\f<knife-kitchen>    \rAir options", {
            [1] = "Zeus", 
            [2] = "Knife", 
            [3] = "Other weapons too"
        }), 
        height_difference = v1760:slider("\a[grey]\f<line-height>    \rH. Gap", 0, 100, 35, 1, function(v1761)
            return v1761 == 0 and "Off" or v1761;
        end)
    }, true;
end);
v1397.safe_head:depend(v70.antiaim.setup);
v1397.safe_head.options:depend({
    [1] = nil, 
    [2] = 1, 
    [1] = v1397.safe_head.states
});
v1397.safe_head:tooltip("\v\f<circle-info>   \rAllows to use safe presets on different states to hide head behind body");
v1397.unsafe_yaw = v53.antiaim.setup_two:switch("\v\f<shield-exclamation>     \rUnsafe yaw", false, nil, function(v1762)
    -- upvalues: v51 (ref)
    local v1763 = {
        events = v1762:listable("\v\f<circle-waveform-lines>    \rEvents", {
            [1] = "Warmup", 
            [2] = "No enemies"
        }), 
        yaw = v1762:list("\a[grey]\f<arrow-right-arrow-left>    \rYaw", {
            [1] = "\f<arrow-rotate-right>    Spin", 
            [2] = "\f<shuffle>    Random"
        }), 
        pitch = v1762:list("\a[grey]\f<arrow-down-arrow-up>     \rPitch", {
            [1] = "\f<circle-small>     Zero", 
            [2] = "\f<arrow-down>    Down"
        })
    };
    v51.set_callback_list(v1763.yaw);
    v51.set_callback_list(v1763.pitch);
    local v1765 = {
        [1] = v1763.events, 
        [2] = function(v1764)
            return #v1764:get() > 0;
        end
    };
    v1763.yaw:depend(v1765);
    v1763.pitch:depend(v1765);
    return v1763, true;
end);
v1397.unsafe_yaw:depend(v70.antiaim.setup);
v1397.view = v53.antiaim.binds:combo("\v\f<magnifying-glass>     \rView", {
    [1] = "At target", 
    [2] = "Local view"
}):depend(v70.antiaim.setup);
v1397.manual = v53.antiaim.binds:combo("\v\f<location-arrow>     \rManual", {
    [1] = "Backward", 
    [2] = "Forward", 
    [3] = "Right", 
    [4] = "Left"
}, nil, function(v1766)
    return {
        static = v1766:switch("\v\f<lock>    \rStatic")
    };
end);
v626 = v1397.manual;
v1397.manual:depend(v70.antiaim.setup);
v1397.freestanding = v53.antiaim.binds:switch("\v\f<arrows-split-up-and-left>     \rFreestand", false, nil, function(v1767)
    return {
        static = v1767:switch("\v\f<lock>    \rStatic")
    };
end);
v1397.freestanding:depend(v70.antiaim.setup);
do
    local l_v1396_2, l_v1397_3, l_v1398_2, l_v1399_0, l_v1400_1, l_v1401_0, l_v1402_0, l_v1403_1, l_v1406_0, l_v1407_1, l_v1408_1, l_v1409_1, l_v1410_1, l_v1411_0, l_v1412_0, l_v1415_1, l_v1416_0, l_v1417_1, l_v1418_0, l_v1419_1, l_v1420_1, l_v1421_1, l_v1422_1 = v1396, v1397, v1398, v1399, v1400, v1401, v1402, v1403, v1406, v1407, v1408, v1409, v1410, v1411, v1412, v1415, v1416, v1417, v1418, v1419, v1420, v1421, v1422;
    l_v1397_3.state = v53.antiaim.state:combo(" \v\f<person-walking>     \rState", v1404, false, nil, function(v1791, v1792)
        -- upvalues: l_v1397_3 (ref), l_v1408_1 (ref), l_v1398_2 (ref), l_base64_0 (ref), l_clipboard_0 (ref), v225 (ref), l_v1407_1 (ref), l_pui_0 (ref), l_v1406_0 (ref)
        local v1793 = {
            use_teams = v1791:switch(" \v\f<person-falling>    \rUse teams")
        };
        v1793.apply_to_opposite_team = v1791:button("          \v\f<share>    \rApply to opposite team          ", nil, true):depend(v1793.use_teams);
        v1793.export_state = v1791:button("    \v\f<file-export>    \rCopy    ", nil, true);
        v1793.import_state = v1791:button("    \v\f<file-import>    \rPaste    ", nil, true);
        v1793.reset_state = v1791:button("   \v\f<rotate-right>   ", nil, true);
        v1793.log = v1791:label("");
        v1793.log:visibility(false);
        local function v1798()
            -- upvalues: v1792 (ref), v1793 (ref), l_v1397_3 (ref), l_v1408_1 (ref), l_v1398_2 (ref)
            local l_value_9 = v1792.value;
            local v1795 = v1793.use_teams.value and l_v1397_3.team.value or l_v1408_1[1];
            for _, v1797 in pairs(l_v1398_2[v1795][l_value_9]) do
                pcall(v1797.reset, v1797);
            end;
        end;
        local function v1809()
            -- upvalues: v1792 (ref), v1793 (ref), l_v1397_3 (ref), l_v1408_1 (ref), l_base64_0 (ref), l_clipboard_0 (ref), v225 (ref), l_v1407_1 (ref), l_pui_0 (ref)
            local v1803, v1804, v1805, v1806, v1807 = pcall(function()
                -- upvalues: v1792 (ref), v1793 (ref), l_v1397_3 (ref), l_v1408_1 (ref), l_base64_0 (ref), l_clipboard_0 (ref), v225 (ref), l_v1407_1 (ref)
                local l_value_10 = v1792.value;
                local v1800 = v1793.use_teams.value and l_v1397_3.team.value or l_v1408_1[1];
                local v1801 = json.parse(l_base64_0.decode(string.match(l_clipboard_0.get(), ">(.-)<")));
                if v1801.settings.antiaim.states[v1801.team][v1801.state].enable == nil then
                    v1801.settings.antiaim.states[v1801.team][v1801.state].enable = true;
                end;
                local v1802 = {
                    antiaim = {
                        states = {
                            [v1800] = {
                                [l_value_10] = v1801.settings.antiaim.states[v1801.team][v1801.state]
                            }
                        }
                    }
                };
                v225.package:load(v1802, "antiaim", "states", v1800, l_value_10);
                return l_v1407_1[v1801.team] or v1801.team, v1801.state, l_v1407_1[v1800] or v1800, l_value_10;
            end);
            local v1808 = l_pui_0.string(v1803 and string.format("\v\f<check>    \r[\v%s\r] \v%s \rsuccessfully imported to \r[\v%s\r] \v%s\r.", v1804, v1805, v1806, v1807) or "\v\f<xmark>   \rSomething went wrong...");
            v1793.log:name(v1808);
            v1793.log:visibility(true);
            utils.execute_after(2, function()
                -- upvalues: v1793 (ref)
                v1793.log:visibility(false);
            end);
        end;
        local function v1819()
            -- upvalues: v1792 (ref), v1793 (ref), l_v1397_3 (ref), l_v1408_1 (ref), l_v1407_1 (ref), v225 (ref), l_clipboard_0 (ref), l_base64_0 (ref), l_pui_0 (ref)
            local v1815, v1816, v1817 = pcall(function()
                -- upvalues: v1792 (ref), v1793 (ref), l_v1397_3 (ref), l_v1408_1 (ref), l_v1407_1 (ref), v225 (ref), l_clipboard_0 (ref), l_base64_0 (ref)
                local l_value_11 = v1792.value;
                local v1811 = v1793.use_teams.value and l_v1397_3.team.value or l_v1408_1[1];
                local v1812 = l_v1407_1[v1811] or v1811;
                local v1813 = v225.package:save("antiaim", "states", v1811, l_value_11);
                local v1814 = {
                    team = v1811, 
                    state = l_value_11, 
                    settings = v1813
                };
                l_clipboard_0.set(("evalate[Builder:%s:%s]>%s<"):format(v1812, l_value_11, l_base64_0.encode(json.stringify(v1814))));
                return l_value_11, v1812;
            end);
            local v1818 = l_pui_0.string(v1815 and string.format("\v\f<check>    \r[\v%s\r] \v%s \rsuccessfully copied.", v1817, v1816) or "\v\f<xmark>   \rSomething went wrong...");
            v1793.log:name(v1818);
            v1793.log:visibility(true);
            utils.execute_after(2, function()
                -- upvalues: v1793 (ref)
                v1793.log:visibility(false);
            end);
        end;
        local function v1830()
            -- upvalues: l_v1397_3 (ref), v1792 (ref), v225 (ref), l_v1406_0 (ref), l_v1407_1 (ref), l_pui_0 (ref), v1793 (ref)
            local v1825, v1826, v1827, v1828 = pcall(function()
                -- upvalues: l_v1397_3 (ref), v1792 (ref), v225 (ref), l_v1406_0 (ref), l_v1407_1 (ref)
                local l_value_12 = l_v1397_3.team.value;
                local l_value_13 = v1792.value;
                local v1822 = v225.package:save("antiaim", "states", l_value_12, l_value_13);
                local v1823 = l_v1397_3.team.value == l_v1406_0[1] and l_v1406_0[2] or l_v1406_0[1];
                local v1824 = {
                    antiaim = {
                        states = {
                            [v1823] = {
                                [l_value_13] = v1822.antiaim.states[l_value_12][l_value_13]
                            }
                        }
                    }
                };
                v225.package:load(v1824, "antiaim", "states", v1823, l_value_13);
                return l_value_13, l_v1407_1[l_value_12], l_v1407_1[v1823];
            end);
            local v1829 = l_pui_0.string(v1825 and string.format("\v\f<check>    \v%s\r's \v%s \rapplied to \v%s\r.", v1827, v1826, v1828) or "\v\f<xmark>   \rSomething went wrong...");
            v1793.log:name(v1829);
            v1793.log:visibility(true);
            utils.execute_after(2, function()
                -- upvalues: v1793 (ref)
                v1793.log:visibility(false);
            end);
        end;
        v1793.reset_state:set_callback(v1798);
        v1793.import_state:set_callback(v1809);
        v1793.export_state:set_callback(v1819);
        v1793.apply_to_opposite_team:set_callback(v1830);
        return v1793;
    end);
    l_v1397_3.state:depend(v70.antiaim.builder);
    l_v1397_3.team = v53.antiaim.state:combo(" \v\f<person-falling>    \rTeam", l_v1406_0);
    l_v1397_3.team:depend(l_v1397_3.state.use_teams, v70.antiaim.builder);
    v53.antiaim.message:label("\aFFA500FF\f<triangle-exclamation>    \rSeems like \aFFA500FFunmatched feature \renabled"):depend(l_v1397_3.unmatched_features.disable_defensive, v70.antiaim.defensive);
    l_v1397_3.defensive_state = v53.antiaim.defensive_state:combo(" \v\f<person-walking>     \rState", v1405, false, nil, function(v1831, v1832)
        -- upvalues: l_v1397_3 (ref), l_v1408_1 (ref), l_v1399_0 (ref), l_base64_0 (ref), l_clipboard_0 (ref), v225 (ref), l_v1407_1 (ref), l_pui_0 (ref), l_v1406_0 (ref)
        local v1833 = {
            use_teams = v1831:switch(" \v\f<person-falling>    \rUse teams")
        };
        v1833.apply_to_opposite_team = v1831:button("          \v\f<share>    \rApply to opposite team          ", nil, true):depend(v1833.use_teams);
        v1833.export_state = v1831:button("    \v\f<file-export>    \rCopy    ", nil, true);
        v1833.import_state = v1831:button("    \v\f<file-import>    \rPaste    ", nil, true);
        v1833.reset_state = v1831:button("   \v\f<rotate-right>   ", nil, true);
        v1833.log = v1831:label("");
        v1833.log:visibility(false);
        local function v1838()
            -- upvalues: v1832 (ref), v1833 (ref), l_v1397_3 (ref), l_v1408_1 (ref), l_v1399_0 (ref)
            local l_value_14 = v1832.value;
            local v1835 = v1833.use_teams.value and l_v1397_3.defensive_team.value or l_v1408_1[1];
            for _, v1837 in pairs(l_v1399_0[v1835][l_value_14]) do
                pcall(v1837.reset, v1837);
            end;
        end;
        local function v1849()
            -- upvalues: v1832 (ref), v1833 (ref), l_v1397_3 (ref), l_v1408_1 (ref), l_base64_0 (ref), l_clipboard_0 (ref), v225 (ref), l_v1407_1 (ref), l_pui_0 (ref)
            local v1843, v1844, v1845, v1846, v1847 = pcall(function()
                -- upvalues: v1832 (ref), v1833 (ref), l_v1397_3 (ref), l_v1408_1 (ref), l_base64_0 (ref), l_clipboard_0 (ref), v225 (ref), l_v1407_1 (ref)
                local l_value_15 = v1832.value;
                local v1840 = v1833.use_teams.value and l_v1397_3.defensive_team.value or l_v1408_1[1];
                local v1841 = json.parse(l_base64_0.decode(string.match(l_clipboard_0.get(), ">(.-)<")));
                local v1842 = {
                    antiaim = {
                        defensive_states = {
                            [v1840] = {
                                [l_value_15] = v1841.settings.antiaim.defensive_states[v1841.team][v1841.state]
                            }
                        }
                    }
                };
                v225.package:load(v1842, "antiaim", "defensive_states", v1840, l_value_15);
                return l_v1407_1[v1841.team] or v1841.team, v1841.state, l_v1407_1[v1840] or v1840, l_value_15;
            end);
            local v1848 = l_pui_0.string(v1843 and string.format("\v\f<check>    \r[\v%s\r] \v%s \rsuccessfully imported to \r[\v%s\r] \v%s\r.", v1844, v1845, v1846, v1847) or "\v\f<xmark>   \rSomething went wrong...");
            v1833.log:name(v1848);
            v1833.log:visibility(true);
            utils.execute_after(2, function()
                -- upvalues: v1833 (ref)
                v1833.log:visibility(false);
            end);
        end;
        local function v1859()
            -- upvalues: v1832 (ref), v1833 (ref), l_v1397_3 (ref), l_v1408_1 (ref), l_v1407_1 (ref), v225 (ref), l_clipboard_0 (ref), l_base64_0 (ref), l_pui_0 (ref)
            local v1855, v1856, v1857 = pcall(function()
                -- upvalues: v1832 (ref), v1833 (ref), l_v1397_3 (ref), l_v1408_1 (ref), l_v1407_1 (ref), v225 (ref), l_clipboard_0 (ref), l_base64_0 (ref)
                local l_value_16 = v1832.value;
                local v1851 = v1833.use_teams.value and l_v1397_3.defensive_team.value or l_v1408_1[1];
                local v1852 = l_v1407_1[v1851] or v1851;
                local v1853 = v225.package:save("antiaim", "defensive_states", v1851, l_value_16);
                local v1854 = {
                    team = v1851, 
                    state = l_value_16, 
                    settings = v1853
                };
                l_clipboard_0.set(("evalate[Builder:%s:%s]>%s<"):format(v1852, l_value_16, l_base64_0.encode(json.stringify(v1854))));
                return l_value_16, v1852;
            end);
            local v1858 = l_pui_0.string(v1855 and string.format("\v\f<check>    \r[\v%s\r] \v%s \rsuccessfully copied.", v1857, v1856) or "\v\f<xmark>   \rSomething went wrong...");
            v1833.log:name(v1858);
            v1833.log:visibility(true);
            utils.execute_after(2, function()
                -- upvalues: v1833 (ref)
                v1833.log:visibility(false);
            end);
        end;
        local function v1870()
            -- upvalues: l_v1397_3 (ref), v1832 (ref), v225 (ref), l_v1406_0 (ref), l_v1407_1 (ref), l_pui_0 (ref), v1833 (ref)
            local v1865, v1866, v1867, v1868 = pcall(function()
                -- upvalues: l_v1397_3 (ref), v1832 (ref), v225 (ref), l_v1406_0 (ref), l_v1407_1 (ref)
                local l_value_17 = l_v1397_3.defensive_team.value;
                local l_value_18 = v1832.value;
                local v1862 = v225.package:save("antiaim", "defensive_states", l_value_17, l_value_18);
                local v1863 = l_v1397_3.defensive_team.value == l_v1406_0[1] and l_v1406_0[2] or l_v1406_0[1];
                local v1864 = {
                    antiaim = {
                        defensive_states = {
                            [v1863] = {
                                [l_value_18] = v1862.antiaim.defensive_states[l_value_17][l_value_18]
                            }
                        }
                    }
                };
                v225.package:load(v1864, "antiaim", "defensive_states", v1863, l_value_18);
                return l_value_18, l_v1407_1[l_value_17], l_v1407_1[v1863];
            end);
            local v1869 = l_pui_0.string(v1865 and string.format("\v\f<check>    \v%s\r's \v%s \rapplied to \v%s\r.", v1867, v1866, v1868) or "\v\f<xmark>   \rSomething went wrong...");
            v1833.log:name(v1869);
            v1833.log:visibility(true);
            utils.execute_after(2, function()
                -- upvalues: v1833 (ref)
                v1833.log:visibility(false);
            end);
        end;
        v1833.reset_state:set_callback(v1838);
        v1833.import_state:set_callback(v1849);
        v1833.export_state:set_callback(v1859);
        v1833.apply_to_opposite_team:set_callback(v1870);
        return v1833;
    end);
    l_v1397_3.defensive_state:depend(v70.antiaim.defensive);
    l_v1397_3.defensive_team = v53.antiaim.defensive_state:combo(" \v\f<person-falling>    \rTeam", l_v1406_0);
    l_v1397_3.defensive_team:depend(l_v1397_3.defensive_state.use_teams, v70.antiaim.defensive);
    l_v1410_1 = function()
        -- upvalues: v265 (ref), v52 (ref)
        local v1871 = nil;
        if v265.is_warmup then
            v1871 = true;
        end;
        v52.fake_duck:override(v1871);
    end;
    l_v1411_0 = function()
        -- upvalues: v52 (ref)
        v52.fake_duck:override();
    end;
    l_v1412_0 = l_v1397_3.unmatched_features.warmup_fake_duck;
    l_v1412_0:set_event("createmove", l_v1410_1);
    do
        local l_l_v1411_0_0 = l_v1411_0;
        l_v1412_0:set_callback(function(v1873)
            -- upvalues: l_l_v1411_0_0 (ref)
            if not v1873.value then
                l_l_v1411_0_0();
            end;
        end);
    end;
    l_v1410_1 = function(v1874, v1875, v1876)
        -- upvalues: v17 (ref)
        local v1877 = v1874 - 1;
        local v1878 = {};
        for v1879 = 0, v1877 do
            v1878[#v1878 + 1] = v17(v1875, v1876, v1879 / v1877);
        end;
        return v1878;
    end;
    l_v1411_0 = function(v1880, v1881, v1882)
        -- upvalues: v265 (ref), v17 (ref)
        local v1883 = v265.realtime % v1880 / v1880;
        return v17(v1881, v1882, math.abs(v1883 * 2 - 1));
    end;
    l_v1412_0 = function(v1884, v1885, v1886)
        -- upvalues: v265 (ref), v17 (ref)
        local v1887 = v265.realtime % v1884 / v1884;
        return v17(v1885, v1886, v1887);
    end;
    v1413 = function(v1888, v1889)
        -- upvalues: l_v1398_2 (ref), l_pui_0 (ref), l_v1400_1 (ref), l_v1403_1 (ref), l_v1401_0 (ref), l_v1402_0 (ref), v51 (ref), l_v1397_3 (ref), v70 (ref)
        l_v1398_2[v1889] = l_v1398_2[v1889] or {};
        l_v1398_2[v1889][v1888] = l_v1398_2[v1889][v1888] or {};
        local v1890 = {
            on = l_pui_0.create(l_v1400_1, string.format("## Builder %s %s On", v1888, v1889), 1), 
            offset = l_pui_0.create(l_v1400_1, string.format("## Builder %s %s Offset", v1888, v1889), 2), 
            modifier = l_pui_0.create(l_v1400_1, string.format("## Builder %s %s Modifier", v1888, v1889), 2), 
            desync = l_pui_0.create(l_v1400_1, string.format("## Builder %s %s Desync", v1888, v1889), 2), 
            extra = l_pui_0.create(l_v1400_1, string.format("## Builder %s %s Extra", v1888, v1889), 2)
        };
        if v1888 ~= l_v1403_1 then
            l_v1398_2[v1889][v1888].enable = v1890.on:switch(" \v\f<check>    \rEnable");
        end;
        l_v1398_2[v1889][v1888].offset = v1890.offset:slider("\v\f<rotate-right>    \rOffset", -180, 180, 0, 1, "\194\176", nil, function(v1891)
            return {
                add_sides = v1891:switch("\v\f<arrow-right-arrow-left>    \rAdd sides"), 
                add_random = v1891:switch("\v\f<shuffle>    \rAdd random")
            };
        end);
        l_v1398_2[v1889][v1888].offset_add_left = v1890.offset:slider("\a[grey]\f<arrow-left>     \rAdd left", -90, 90, 0, 1, "\194\176");
        l_v1398_2[v1889][v1888].offset_add_right = v1890.offset:slider("\a[grey]\f<arrow-right>     \rAdd right", -90, 90, 0, 1, "\194\176");
        l_v1398_2[v1889][v1888].offset_add_random = v1890.offset:slider("\a[grey]\f<shuffle>    \rAdd random", 0, 50, 0, 1, "\194\176");
        l_v1398_2[v1889][v1888].modifier = v1890.modifier:combo("\v\f<arrows-left-right-to-line>   \rModifier", {
            [1] = "None", 
            [2] = "Center", 
            [3] = "Offset", 
            [4] = "Random", 
            [5] = "Ways", 
            [6] = "Spin", 
            [7] = "Sway"
        }, nil, function(v1892, v1893)
            local v1894 = {
                min_max = v1892:switch("\v\f<split>    \rMin / Max"), 
                custom_ways = v1892:switch("\v\f<layer-group>    \rCustom ways"):depend({
                    [1] = nil, 
                    [2] = "Ways", 
                    [1] = v1893
                }), 
                apply_delay = v1892:switch("\v\f<clock-rotate-left>    \rApply delay", true):depend({
                    [1] = nil, 
                    [2] = "Center", 
                    [3] = "Offset", 
                    [1] = v1893
                })
            };
            v1894.min_max:depend({
                [1] = nil, 
                [2] = "None", 
                [3] = true, 
                [1] = v1893
            }, {
                [1] = nil, 
                [2] = false, 
                [1] = v1894.custom_ways
            });
            return v1894;
        end);
        l_v1398_2[v1889][v1888].ways_count = v1890.modifier:slider("\a[grey]\f<layer-plus>     \rWays", l_v1401_0, l_v1402_0, l_v1401_0);
        l_v1398_2[v1889][v1888].ways = v1890.modifier:label("\a[grey]\f<layer-group>     \rDegrees", nil, function(v1895)
            -- upvalues: l_v1402_0 (ref), l_v1398_2 (ref), v1889 (ref), v1888 (ref)
            local v1896 = {};
            for v1897 = 1, l_v1402_0 do
                do
                    local l_v1897_0 = v1897;
                    local function v1900(v1899)
                        -- upvalues: l_v1897_0 (ref)
                        return l_v1897_0 <= v1899.value;
                    end;
                    v1896[tostring(l_v1897_0)] = v1895:slider(string.format("\a[grey]\f<angle>    \rDegree   \a[grey]%s", l_v1897_0), -180, 180, 0, 1, "\194\176"):depend({
                        [1] = l_v1398_2[v1889][v1888].ways_count, 
                        [2] = v1900
                    });
                end;
            end;
            return v1896;
        end);
        l_v1398_2[v1889][v1888].speed = v1890.modifier:slider("\a[grey]\f<timer>    \rSpeed", 1, 100, 50, 1, "%");
        l_v1398_2[v1889][v1888].degree = v1890.modifier:slider("\a[grey]\f<angle>     \rDegree", -180, 180, 0, 1, "\194\176");
        l_v1398_2[v1889][v1888].degree_min = v1890.modifier:slider(" \a[grey]\f<arrow-down-right>     \rMin", -180, 180, 0, 1, "\194\176");
        l_v1398_2[v1889][v1888].degree_max = v1890.modifier:slider(" \a[grey]\f<arrow-up-right>     \rMax", -180, 180, 0, 1, "\194\176");
        l_v1398_2[v1889][v1888].desync = v1890.desync:switch("\v\f<wave-triangle>   \rDesync", false, nil, function(v1901)
            -- upvalues: v51 (ref)
            local v1902 = {
                limits_value = v1901:list("\v\f<arrow-down-left-and-arrow-up-right-to-center>    \rLimits", {
                    [1] = "\f<circle>    Static", 
                    [2] = "\f<shuffle>    Random"
                })
            };
            v51.set_callback_list(v1902.limits_value);
            v1902.desync_state = v1901:list("\v\f<power-off>    \rState", {
                [1] = "\f<power-off>    Always on", 
                [2] = "\f<shuffle>    Random", 
                [3] = "\f<clock-rotate-left>    Delay"
            });
            v51.set_callback_list(v1902.desync_state);
            v1902.delay = v1901:slider("\a[grey]\f<clock-rotate-left>    \rDelay", 1, 20, 6, 1, "t"):depend({
                [1] = nil, 
                [2] = 3, 
                [1] = v1902.desync_state
            });
            return v1902, true;
        end);
        l_v1398_2[v1889][v1888].left_limit = v1890.desync:slider("\a[grey]\f<arrow-left>     \rLeft limit", 0, 58, 58, 1, "\194\176");
        l_v1398_2[v1889][v1888].right_limit = v1890.desync:slider("\a[grey]\f<arrow-right>     \rRight limit", 0, 58, 58, 1, "\194\176");
        l_v1398_2[v1889][v1888].limit_min = v1890.desync:slider(" \a[grey]\f<arrow-down-right>     \rLimit min", 0, 58, 29, 1, "\194\176");
        l_v1398_2[v1889][v1888].limit_max = v1890.desync:slider(" \a[grey]\f<arrow-up-right>     \rLimit max", 0, 58, 52, 1, "\194\176");
        l_v1398_2[v1889][v1888].options = v1890.desync:label("\a[grey]\f<bars>     \rOptions", nil, function(v1903)
            return {
                jitter = v1903:switch("\v\f<right-left>     \rJitter"), 
                inverter = v1903:switch("\v\f<location-arrow>      \rInverter"), 
                freestanding = v1903:combo(" \v\f<arrow-left-to-line>      \rFreestanding", {
                    [1] = "Off", 
                    [2] = "Peek Real", 
                    [3] = "Peek Fake"
                })
            };
        end);
        l_v1398_2[v1889][v1888].delay = v1890.extra:switch("\v\f<clock-rotate-left>    \rDelay", false, nil, function(v1904, _)
            -- upvalues: v51 (ref)
            local v1906 = {
                mode = v1904:list("\v\f<hourglass>    \rMode", {
                    [1] = "\f<angle>    Static", 
                    [2] = "\f<layer-group>    Staged", 
                    [3] = "\f<arrow-right-arrow-left>    \rBy sides", 
                    [4] = "\f<shuffle>    Random"
                })
            };
            v51.set_callback_list(v1906.mode);
            v1906.stages_count = v1904:slider("\a[grey]\f<layer-plus>    \rStages", 2, 8, 3, 1, "x"):depend({
                [1] = nil, 
                [2] = 2, 
                [1] = v1906.mode
            });
            for v1907 = 1, 8 do
                do
                    local l_v1907_0 = v1907;
                    local function v1910(v1909)
                        -- upvalues: l_v1907_0 (ref)
                        return l_v1907_0 <= v1909.value;
                    end;
                    v1906[tostring(l_v1907_0)] = v1904:slider(string.format("\a[grey]\f<angle>     \rStage  \a[grey]%s", l_v1907_0), 1, 16, 2, 1, "t"):depend({
                        [1] = nil, 
                        [2] = 2, 
                        [1] = v1906.mode
                    }, {
                        [1] = v1906.stages_count, 
                        [2] = v1910
                    });
                end;
            end;
            v1906.min_max_sides = v1904:switch("\v\f<split>    \rMin / Max"):depend({
                [1] = nil, 
                [2] = 3, 
                [1] = v1906.mode
            });
            v1906.min = v1904:slider(" \a[grey]\f<arrow-down-right>     \rMin", 1, 16, 2, 1, "t"):depend({
                [1] = nil, 
                [2] = 4, 
                [1] = v1906.mode
            });
            v1906.max = v1904:slider(" \a[grey]\f<arrow-up-right>     \rMax", 1, 16, 5, 1, "t"):depend({
                [1] = nil, 
                [2] = 4, 
                [1] = v1906.mode
            });
            v1906.static = v1904:slider("\a[grey]\f<angle>    \rStatic", 1, 16, 2, 1, "t"):depend({
                [1] = nil, 
                [2] = 1, 
                [1] = v1906.mode
            });
            v1906.left = v1904:slider("\a[grey]\f<arrow-left>     \rLeft", 1, 16, 1, 1, "t"):depend({
                [1] = nil, 
                [2] = 3, 
                [1] = v1906.mode
            }, {
                [1] = nil, 
                [2] = false, 
                [1] = v1906.min_max_sides
            });
            v1906.right = v1904:slider("\a[grey]\f<arrow-right>     \rRight", 1, 16, 16, 1, "t"):depend({
                [1] = nil, 
                [2] = 3, 
                [1] = v1906.mode
            }, {
                [1] = nil, 
                [2] = false, 
                [1] = v1906.min_max_sides
            });
            v1906.left_min = v1904:slider(" \a[grey]\f<arrow-down-right>     \rLeft min", 1, 16, 1, 1, "t"):depend({
                [1] = nil, 
                [2] = 3, 
                [1] = v1906.mode
            }, v1906.min_max_sides);
            v1906.left_max = v1904:slider(" \a[grey]\f<arrow-up-right>     \rLeft max", 1, 16, 4, 1, "t"):depend({
                [1] = nil, 
                [2] = 3, 
                [1] = v1906.mode
            }, v1906.min_max_sides);
            v1906.right_min = v1904:slider(" \a[grey]\f<arrow-down-right>     \rRight min", 1, 16, 10, 1, "t"):depend({
                [1] = nil, 
                [2] = 3, 
                [1] = v1906.mode
            }, v1906.min_max_sides);
            v1906.right_max = v1904:slider(" \a[grey]\f<arrow-up-right>     \rRight max", 1, 16, 16, 1, "t"):depend({
                [1] = nil, 
                [2] = 3, 
                [1] = v1906.mode
            }, v1906.min_max_sides);
            return v1906, true;
        end);
        l_v1398_2[v1889][v1888].freeze_inverter = v1890.extra:switch("\v\f<snowflake>    \rFreeze", false, nil, function(v1911)
            return {
                chance = v1911:slider("\v\f<angle>      \rChance", 0, 100, 50, 1, "%"), 
                duration = v1911:slider("\v\f<clock-rotate-left>      \rDuration", 1, 80, 10, 1, "t")
            }, true;
        end);
        l_v1398_2[v1889][v1888].force_disable = v1890.extra:selectable(" \v\f<xmark>     \rForce disable", {
            [1] = "Manual", 
            [2] = "Freestand"
        });
        local function v1912()
            -- upvalues: l_v1397_3 (ref), v1889 (ref)
            if l_v1397_3.state.use_teams.value then
                return l_v1397_3.team.value == v1889;
            else
                return v1889 == "Base";
            end;
        end;
        local v1913 = {
            [1] = {
                [1] = l_v1397_3.state, 
                [2] = v1888
            }, 
            [2] = {
                [1] = l_v1397_3.team, 
                [2] = v1912
            }, 
            [3] = {
                [1] = l_v1397_3.state.use_teams, 
                [2] = v1912
            }, 
            [4] = v70.antiaim.builder
        };
        if v1888 ~= l_v1403_1 then
            l_v1398_2[v1889][v1888].enable:depend(unpack(v1913));
        end;
        v1913[#v1913 + 1] = l_v1398_2[v1889][v1888].enable;
        l_v1398_2[v1889][v1888].offset:depend(unpack(v1913));
        l_v1398_2[v1889][v1888].offset_add_left:depend(l_v1398_2[v1889][v1888].offset.add_sides, unpack(v1913));
        l_v1398_2[v1889][v1888].offset_add_right:depend(l_v1398_2[v1889][v1888].offset.add_sides, unpack(v1913));
        l_v1398_2[v1889][v1888].offset_add_random:depend(l_v1398_2[v1889][v1888].offset.add_random, unpack(v1913));
        l_v1398_2[v1889][v1888].modifier:depend(unpack(v1913));
        l_v1398_2[v1889][v1888].degree:depend({
            [1] = nil, 
            [2] = "None", 
            [3] = true, 
            [1] = l_v1398_2[v1889][v1888].modifier
        }, {
            [1] = nil, 
            [2] = false, 
            [1] = l_v1398_2[v1889][v1888].modifier.min_max
        }, {
            [1] = nil, 
            [2] = false, 
            [1] = l_v1398_2[v1889][v1888].modifier.custom_ways
        }, unpack(v1913));
        l_v1398_2[v1889][v1888].degree_min:depend({
            [1] = nil, 
            [2] = "None", 
            [3] = true, 
            [1] = l_v1398_2[v1889][v1888].modifier
        }, {
            [1] = nil, 
            [2] = true, 
            [1] = l_v1398_2[v1889][v1888].modifier.min_max
        }, {
            [1] = nil, 
            [2] = false, 
            [1] = l_v1398_2[v1889][v1888].modifier.custom_ways
        }, unpack(v1913));
        l_v1398_2[v1889][v1888].degree_max:depend({
            [1] = nil, 
            [2] = "None", 
            [3] = true, 
            [1] = l_v1398_2[v1889][v1888].modifier
        }, {
            [1] = nil, 
            [2] = true, 
            [1] = l_v1398_2[v1889][v1888].modifier.min_max
        }, {
            [1] = nil, 
            [2] = false, 
            [1] = l_v1398_2[v1889][v1888].modifier.custom_ways
        }, unpack(v1913));
        l_v1398_2[v1889][v1888].speed:depend({
            [1] = nil, 
            [2] = "Spin", 
            [3] = "Sway", 
            [1] = l_v1398_2[v1889][v1888].modifier
        }, unpack(v1913));
        l_v1398_2[v1889][v1888].ways_count:depend({
            [1] = nil, 
            [2] = "Ways", 
            [1] = l_v1398_2[v1889][v1888].modifier
        }, unpack(v1913));
        l_v1398_2[v1889][v1888].ways:depend({
            [1] = nil, 
            [2] = "Ways", 
            [1] = l_v1398_2[v1889][v1888].modifier
        }, l_v1398_2[v1889][v1888].modifier.custom_ways, unpack(v1913));
        l_v1398_2[v1889][v1888].desync:depend(unpack(v1913));
        l_v1398_2[v1889][v1888].left_limit:depend(l_v1398_2[v1889][v1888].desync, {
            [1] = nil, 
            [2] = 1, 
            [1] = l_v1398_2[v1889][v1888].desync.limits_value
        }, unpack(v1913));
        l_v1398_2[v1889][v1888].right_limit:depend(l_v1398_2[v1889][v1888].desync, {
            [1] = nil, 
            [2] = 1, 
            [1] = l_v1398_2[v1889][v1888].desync.limits_value
        }, unpack(v1913));
        l_v1398_2[v1889][v1888].limit_min:depend(l_v1398_2[v1889][v1888].desync, {
            [1] = nil, 
            [2] = 2, 
            [1] = l_v1398_2[v1889][v1888].desync.limits_value
        }, unpack(v1913));
        l_v1398_2[v1889][v1888].limit_max:depend(l_v1398_2[v1889][v1888].desync, {
            [1] = nil, 
            [2] = 2, 
            [1] = l_v1398_2[v1889][v1888].desync.limits_value
        }, unpack(v1913));
        l_v1398_2[v1889][v1888].options:depend(l_v1398_2[v1889][v1888].desync, unpack(v1913));
        l_v1398_2[v1889][v1888].delay:depend(unpack(v1913));
        l_v1398_2[v1889][v1888].freeze_inverter:depend(unpack(v1913));
        l_v1398_2[v1889][v1888].force_disable:depend(unpack(v1913));
    end;
    for _, v1915 in ipairs(v1404) do
        for _, v1917 in ipairs(l_v1408_1) do
            v1413(v1915, v1917);
        end;
    end;
    v1414 = function(v1918, v1919)
        -- upvalues: l_v1399_0 (ref), l_pui_0 (ref), l_v1400_1 (ref), l_v1401_0 (ref), l_v1402_0 (ref), v51 (ref), l_v1397_3 (ref), v70 (ref)
        l_v1399_0[v1919] = l_v1399_0[v1919] or {};
        l_v1399_0[v1919][v1918] = l_v1399_0[v1919][v1918] or {};
        local v1920 = {
            on = l_pui_0.create(l_v1400_1, string.format("## Defensive Builder %s %s On", v1918, v1919), 1), 
            yaw = l_pui_0.create(l_v1400_1, string.format("## Defensive Builder %s %s Yaw", v1918, v1919), 2), 
            modifier = l_pui_0.create(l_v1400_1, string.format("## Defensive Builder %s %s Modifier", v1918, v1919), 2), 
            pitch = l_pui_0.create(l_v1400_1, string.format("## Defensive Builder %s %s Pitch", v1918, v1919), 2), 
            duration = l_pui_0.create(l_v1400_1, string.format("## Defensive Builder %s %s Duration", v1918, v1919), 2)
        };
        l_v1399_0[v1919][v1918].enable = v1920.on:switch(" \v\f<check>     \rEnable", false, nil, function(v1921)
            return {
                remove_modifier = v1921:switch("\v\f<not-equal>    \rRemove modifier")
            }, true;
        end);
        l_v1399_0[v1919][v1918].force_break_lc = v1920.on:switch("\v\f<signal-stream>     \rForce Break LC", false, nil, function(v1922)
            return {
                allow_double_tap = v1922:switch("\v\f<seedling>    \rAllow double tap", true), 
                allow_hide_shots = v1922:switch("\v\f<leaf>    \rAllow hide shots", true)
            }, true;
        end);
        l_v1399_0[v1919][v1918].custom_tickbase = v1920.on:switch("\a[grey]\f<wave-sine>    \rCustom tickbase", false, nil, function(v1923)
            return {
                static = v1923:slider("\a[grey]\f<angle>    \rStatic", 1, 22, 16, 1, "t")
            }, true;
        end);
        local function v1925(v1924)
            if v1924 == 1 then
                return "Off";
            else
                return string.format("%st", v1924);
            end;
        end;
        l_v1399_0[v1919][v1918].yaw = v1920.yaw:combo("\v\f<rotate-right>    \rYaw", {
            [1] = "None", 
            [2] = "Swap", 
            [3] = "Static", 
            [4] = "Switch", 
            [5] = "Random", 
            [6] = "Ways", 
            [7] = "Spin", 
            [8] = "Sway", 
            [9] = "Peek direction"
        }, nil, function(v1926, v1927)
            local v1928 = {
                min_max = v1926:switch("\v\f<split>    \rMin / Max"), 
                custom_ways = v1926:switch("\v\f<layer-group>    \rCustom ways")
            };
            local function v1930()
                -- upvalues: v1927 (ref), v1928 (ref)
                local l_value_19 = v1927.value;
                return (not v1928.custom_ways.value or l_value_19 ~= "Ways") and l_value_19 ~= "None" and l_value_19 ~= "Static" and l_value_19 ~= "Peek direction";
            end;
            v1928.min_max:depend({
                [1] = v1927, 
                [2] = v1930
            }, {
                [1] = v1928.custom_ways, 
                [2] = v1930
            });
            v1928.custom_ways:depend({
                [1] = nil, 
                [2] = "Ways", 
                [1] = v1927
            });
            return v1928;
        end);
        l_v1399_0[v1919][v1918].yaw_ways_count = v1920.yaw:slider("\a[grey]\f<layer-plus>     \rWays", l_v1401_0, l_v1402_0, l_v1401_0);
        l_v1399_0[v1919][v1918].yaw_ways = v1920.yaw:label("\a[grey]\f<layer-group>     \rDegrees", nil, function(v1931)
            -- upvalues: l_v1402_0 (ref), l_v1399_0 (ref), v1919 (ref), v1918 (ref)
            local v1932 = {};
            for v1933 = 1, l_v1402_0 do
                do
                    local l_v1933_0 = v1933;
                    local function v1936(v1935)
                        -- upvalues: l_v1933_0 (ref)
                        return l_v1933_0 <= v1935.value;
                    end;
                    v1932[tostring(l_v1933_0)] = v1931:slider(string.format("\a[grey]\f<angle>    \rDegree   \a[grey]%s", l_v1933_0), -180, 180, 0, 1, "\194\176"):depend({
                        [1] = l_v1399_0[v1919][v1918].yaw_ways_count, 
                        [2] = v1936
                    });
                end;
            end;
            return v1932;
        end);
        l_v1399_0[v1919][v1918].yaw_speed = v1920.yaw:slider("\a[grey]\f<timer>    \rSpeed", 1, 200, 100, 0.01, "s");
        l_v1399_0[v1919][v1918].yaw_delay = v1920.yaw:slider("\a[grey]\f<timer>    \rDelay", 1, 20, 0, 1, v1925);
        l_v1399_0[v1919][v1918].yaw_degree = v1920.yaw:slider("\a[grey]\f<angle>     \rDegree", -180, 180, 0, 1, "\194\176");
        l_v1399_0[v1919][v1918].yaw_degree_min = v1920.yaw:slider(" \a[grey]\f<arrow-down-right>     \rMin", -180, 180, 0, 1, "\194\176");
        l_v1399_0[v1919][v1918].yaw_degree_max = v1920.yaw:slider(" \a[grey]\f<arrow-up-right>     \rMax", -180, 180, 0, 1, "\194\176");
        l_v1399_0[v1919][v1918].modifier = v1920.modifier:combo("\v\f<arrow-right-arrow-left>    \rModifier", {
            [1] = "None", 
            [2] = "Static", 
            [3] = "Swap", 
            [4] = "Switch", 
            [5] = "Random", 
            [6] = "Ways", 
            [7] = "Spin", 
            [8] = "Sway", 
            [9] = "Peek direction"
        }, nil, function(v1937, v1938)
            local v1939 = {
                min_max = v1937:switch("\v\f<split>    \rMin / Max"), 
                custom_ways = v1937:switch("\v\f<layer-group>    \rCustom ways")
            };
            local function v1941()
                -- upvalues: v1938 (ref), v1939 (ref)
                local l_value_20 = v1938.value;
                return (not v1939.custom_ways.value or l_value_20 ~= "Ways") and l_value_20 ~= "None" and l_value_20 ~= "Static" and l_value_20 ~= "Peek direction";
            end;
            v1939.min_max:depend({
                [1] = v1938, 
                [2] = v1941
            }, {
                [1] = v1939.custom_ways, 
                [2] = v1941
            });
            v1939.custom_ways:depend({
                [1] = nil, 
                [2] = "Ways", 
                [1] = v1938
            });
            return v1939;
        end);
        l_v1399_0[v1919][v1918].modifier_ways_count = v1920.modifier:slider("\a[grey]\f<layer-plus>     \rWays", l_v1401_0, l_v1402_0, l_v1401_0);
        l_v1399_0[v1919][v1918].modifier_ways = v1920.modifier:label("\a[grey]\f<layer-group>     \rDegrees", nil, function(v1942)
            -- upvalues: l_v1402_0 (ref), l_v1399_0 (ref), v1919 (ref), v1918 (ref)
            local v1943 = {};
            for v1944 = 1, l_v1402_0 do
                do
                    local l_v1944_0 = v1944;
                    local function v1947(v1946)
                        -- upvalues: l_v1944_0 (ref)
                        return l_v1944_0 <= v1946.value;
                    end;
                    v1943[tostring(l_v1944_0)] = v1942:slider(string.format("\a[grey]\f<angle>    \rDegree   \a[grey]%s", l_v1944_0), -180, 180, 0, 1, "\194\176"):depend({
                        [1] = l_v1399_0[v1919][v1918].modifier_ways_count, 
                        [2] = v1947
                    });
                end;
            end;
            return v1943;
        end);
        l_v1399_0[v1919][v1918].modifier_speed = v1920.modifier:slider("\a[grey]\f<timer>    \rSpeed", 1, 200, 100, 0.01, "s");
        l_v1399_0[v1919][v1918].modifier_delay = v1920.modifier:slider("\a[grey]\f<timer>    \rDelay", 1, 20, 0, 1, v1925);
        l_v1399_0[v1919][v1918].modifier_degree = v1920.modifier:slider("\a[grey]\f<angle>     \rDegree", -180, 180, 0, 1, "\194\176");
        l_v1399_0[v1919][v1918].modifier_degree_min = v1920.modifier:slider(" \a[grey]\f<arrow-down-right>     \rMin", -180, 180, 0, 1, "\194\176");
        l_v1399_0[v1919][v1918].modifier_degree_max = v1920.modifier:slider(" \a[grey]\f<arrow-up-right>     \rMax", -180, 180, 0, 1, "\194\176");
        local function v1949(v1948)
            if v1948 == -89 then
                return "Up";
            elseif v1948 == 89 then
                return "Down";
            elseif v1948 == 0 then
                return "Zero";
            else
                return string.format("%s\194\176", v1948);
            end;
        end;
        l_v1399_0[v1919][v1918].pitch = v1920.pitch:combo("\v\f<arrow-down-arrow-up>     \rPitch", {
            [1] = "None", 
            [2] = "Static", 
            [3] = "Swap", 
            [4] = "Switch", 
            [5] = "Random", 
            [6] = "Ways", 
            [7] = "Spin", 
            [8] = "Sway"
        }, nil, function(v1950, v1951)
            local v1952 = {
                min_max = v1950:switch("\v\f<split>    \rMin / Max"), 
                custom_ways = v1950:switch("\v\f<layer-group>    \rCustom ways")
            };
            local function v1954()
                -- upvalues: v1951 (ref), v1952 (ref)
                local l_value_21 = v1951.value;
                return (not v1952.custom_ways.value or l_value_21 ~= "Ways") and l_value_21 ~= "None" and l_value_21 ~= "Static";
            end;
            v1952.min_max:depend({
                [1] = v1951, 
                [2] = v1954
            }, {
                [1] = v1952.custom_ways, 
                [2] = v1954
            });
            v1952.custom_ways:depend({
                [1] = nil, 
                [2] = "Ways", 
                [1] = v1951
            });
            return v1952;
        end);
        l_v1399_0[v1919][v1918].pitch_ways_count = v1920.pitch:slider("\a[grey]\f<layer-plus>     \rWays", l_v1401_0, l_v1402_0, l_v1401_0);
        l_v1399_0[v1919][v1918].pitch_ways = v1920.pitch:label("\a[grey]\f<layer-group>     \rDegrees", nil, function(v1955)
            -- upvalues: l_v1402_0 (ref), v1949 (ref), l_v1399_0 (ref), v1919 (ref), v1918 (ref)
            local v1956 = {};
            for v1957 = 1, l_v1402_0 do
                do
                    local l_v1957_0 = v1957;
                    local function v1960(v1959)
                        -- upvalues: l_v1957_0 (ref)
                        return l_v1957_0 <= v1959.value;
                    end;
                    v1956[tostring(l_v1957_0)] = v1955:slider(string.format("\a[grey]\f<angle>    \rDegree   \a[grey]%s", l_v1957_0), -89, 89, 0, 1, v1949):depend({
                        [1] = l_v1399_0[v1919][v1918].pitch_ways_count, 
                        [2] = v1960
                    });
                end;
            end;
            return v1956;
        end);
        l_v1399_0[v1919][v1918].pitch_speed = v1920.pitch:slider("\a[grey]\f<timer>    \rSpeed", 1, 200, 100, 0.01, "s");
        l_v1399_0[v1919][v1918].pitch_delay = v1920.pitch:slider("\a[grey]\f<timer>    \rDelay", 1, 20, 0, 1, v1925);
        l_v1399_0[v1919][v1918].pitch_degree = v1920.pitch:slider("\a[grey]\f<angle>     \rDegree", -89, 89, 0, 1, v1949);
        l_v1399_0[v1919][v1918].pitch_degree_min = v1920.pitch:slider(" \a[grey]\f<arrow-down-right>     \rMin", -89, 89, 0, 1, v1949);
        l_v1399_0[v1919][v1918].pitch_degree_max = v1920.pitch:slider(" \a[grey]\f<arrow-up-right>     \rMax", -89, 89, 0, 1, v1949);
        local function v1962(v1961)
            if v1961 == 13 then
                return "Max";
            elseif v1961 == 1 then
                return "Min";
            else
                return string.format("%st", v1961);
            end;
        end;
        l_v1399_0[v1919][v1918].duration = v1920.duration:switch("\v\f<clock-rotate-left>     \rCustom duration", false, nil, function(v1963)
            -- upvalues: v51 (ref), v1962 (ref)
            local v1964 = {
                mode = v1963:list("\v\f<hourglass>    \rMode", {
                    [1] = "\f<angle>    Static", 
                    [2] = "\f<layer-group>    Staged", 
                    [3] = "\f<shuffle>    Random"
                })
            };
            v51.set_callback_list(v1964.mode);
            v1964.stages_count = v1963:slider("\a[grey]\f<layer-plus>    \rStages", 2, 8, 3, 1, "x"):depend({
                [1] = nil, 
                [2] = 2, 
                [1] = v1964.mode
            });
            for v1965 = 1, 8 do
                do
                    local l_v1965_0 = v1965;
                    local function v1968(v1967)
                        -- upvalues: l_v1965_0 (ref)
                        return l_v1965_0 <= v1967.value;
                    end;
                    v1964[tostring(l_v1965_0)] = v1963:slider(string.format("\a[grey]\f<angle>     \rStage  \a[grey]%s", l_v1965_0), 1, 13, 13, 1, v1962):depend({
                        [1] = nil, 
                        [2] = 2, 
                        [1] = v1964.mode
                    }, {
                        [1] = v1964.stages_count, 
                        [2] = v1968
                    });
                end;
            end;
            v1964.min = v1963:slider(" \a[grey]\f<arrow-down-right>     \rMin", 1, 13, 1, 1, v1962):depend({
                [1] = nil, 
                [2] = 3, 
                [1] = v1964.mode
            });
            v1964.max = v1963:slider(" \a[grey]\f<arrow-up-right>     \rMax", 1, 13, 13, 1, v1962):depend({
                [1] = nil, 
                [2] = 3, 
                [1] = v1964.mode
            });
            v1964.static = v1963:slider("\a[grey]\f<angle>    \rStatic", 1, 13, 13, 1, v1962):depend({
                [1] = nil, 
                [2] = 1, 
                [1] = v1964.mode
            });
            return v1964, true;
        end);
        local function v1969()
            -- upvalues: l_v1397_3 (ref), v1919 (ref)
            if l_v1397_3.defensive_state.use_teams.value then
                return l_v1397_3.defensive_team.value == v1919;
            else
                return v1919 == "Base";
            end;
        end;
        local v1970 = {
            [1] = {
                [1] = l_v1397_3.defensive_state, 
                [2] = v1918
            }, 
            [2] = {
                [1] = l_v1397_3.defensive_team, 
                [2] = v1969
            }, 
            [3] = {
                [1] = l_v1397_3.defensive_state.use_teams, 
                [2] = v1969
            }, 
            [4] = v70.antiaim.defensive
        };
        l_v1399_0[v1919][v1918].enable:depend(unpack(v1970));
        v1970[#v1970 + 1] = l_v1399_0[v1919][v1918].enable;
        l_v1399_0[v1919][v1918].force_break_lc:depend(unpack(v1970));
        local function v1975(v1971, v1972)
            -- upvalues: l_v1399_0 (ref), v1919 (ref), v1918 (ref)
            local v1973 = l_v1399_0[v1919][v1918][v1971];
            return function()
                -- upvalues: v1973 (ref), v1972 (ref)
                local l_value_22 = v1973.value;
                if l_value_22 == "None" or l_value_22 == "Peek direction" then
                    return false;
                elseif l_value_22 == "Static" then
                    return v1972 == nil;
                elseif l_value_22 == "Ways" and v1973.custom_ways.value then
                    return false;
                elseif v1972 then
                    return v1973.min_max.value;
                else
                    return not v1973.min_max.value;
                end;
            end;
        end;
        l_v1399_0[v1919][v1918].yaw:depend(unpack(v1970));
        l_v1399_0[v1919][v1918].yaw_degree:depend({
            l_v1399_0[v1919][v1918].yaw, 
            v1975("yaw")
        }, {
            l_v1399_0[v1919][v1918].yaw.min_max, 
            v1975("yaw")
        }, {
            l_v1399_0[v1919][v1918].yaw.custom_ways, 
            v1975("yaw")
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].yaw_degree_min:depend({
            l_v1399_0[v1919][v1918].yaw, 
            v1975("yaw", true)
        }, {
            l_v1399_0[v1919][v1918].yaw.min_max, 
            v1975("yaw", true)
        }, {
            l_v1399_0[v1919][v1918].yaw.custom_ways, 
            v1975("yaw", true)
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].yaw_degree_max:depend({
            l_v1399_0[v1919][v1918].yaw, 
            v1975("yaw", true)
        }, {
            l_v1399_0[v1919][v1918].yaw.min_max, 
            v1975("yaw", true)
        }, {
            l_v1399_0[v1919][v1918].yaw.custom_ways, 
            v1975("yaw", true)
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].yaw_delay:depend({
            [1] = nil, 
            [2] = "Switch", 
            [1] = l_v1399_0[v1919][v1918].yaw
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].yaw_speed:depend({
            [1] = nil, 
            [2] = "Spin", 
            [3] = "Sway", 
            [1] = l_v1399_0[v1919][v1918].yaw
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].yaw_ways_count:depend({
            [1] = nil, 
            [2] = "Ways", 
            [1] = l_v1399_0[v1919][v1918].yaw
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].yaw_ways:depend({
            [1] = nil, 
            [2] = "Ways", 
            [1] = l_v1399_0[v1919][v1918].yaw
        }, l_v1399_0[v1919][v1918].yaw.custom_ways, unpack(v1970));
        l_v1399_0[v1919][v1918].modifier:depend(unpack(v1970));
        l_v1399_0[v1919][v1918].modifier_degree:depend({
            l_v1399_0[v1919][v1918].modifier, 
            v1975("modifier")
        }, {
            l_v1399_0[v1919][v1918].modifier.min_max, 
            v1975("modifier")
        }, {
            l_v1399_0[v1919][v1918].modifier.custom_ways, 
            v1975("modifier")
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].modifier_degree_min:depend({
            l_v1399_0[v1919][v1918].modifier, 
            v1975("modifier", true)
        }, {
            l_v1399_0[v1919][v1918].modifier.min_max, 
            v1975("modifier", true)
        }, {
            l_v1399_0[v1919][v1918].modifier.custom_ways, 
            v1975("modifier", true)
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].modifier_degree_max:depend({
            l_v1399_0[v1919][v1918].modifier, 
            v1975("modifier", true)
        }, {
            l_v1399_0[v1919][v1918].modifier.min_max, 
            v1975("modifier", true)
        }, {
            l_v1399_0[v1919][v1918].modifier.custom_ways, 
            v1975("modifier", true)
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].modifier_delay:depend({
            [1] = nil, 
            [2] = "Switch", 
            [1] = l_v1399_0[v1919][v1918].modifier
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].modifier_speed:depend({
            [1] = nil, 
            [2] = "Spin", 
            [3] = "Sway", 
            [1] = l_v1399_0[v1919][v1918].modifier
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].modifier_ways_count:depend({
            [1] = nil, 
            [2] = "Ways", 
            [1] = l_v1399_0[v1919][v1918].modifier
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].modifier_ways:depend({
            [1] = nil, 
            [2] = "Ways", 
            [1] = l_v1399_0[v1919][v1918].modifier
        }, l_v1399_0[v1919][v1918].modifier.custom_ways, unpack(v1970));
        l_v1399_0[v1919][v1918].pitch:depend(unpack(v1970));
        l_v1399_0[v1919][v1918].pitch_degree:depend({
            l_v1399_0[v1919][v1918].pitch, 
            v1975("pitch")
        }, {
            l_v1399_0[v1919][v1918].pitch.min_max, 
            v1975("pitch")
        }, {
            l_v1399_0[v1919][v1918].pitch.custom_ways, 
            v1975("pitch")
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].pitch_degree_min:depend({
            l_v1399_0[v1919][v1918].pitch, 
            v1975("pitch", true)
        }, {
            l_v1399_0[v1919][v1918].pitch.min_max, 
            v1975("pitch", true)
        }, {
            l_v1399_0[v1919][v1918].pitch.custom_ways, 
            v1975("pitch", true)
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].pitch_degree_max:depend({
            l_v1399_0[v1919][v1918].pitch, 
            v1975("pitch", true)
        }, {
            l_v1399_0[v1919][v1918].pitch.min_max, 
            v1975("pitch", true)
        }, {
            l_v1399_0[v1919][v1918].pitch.custom_ways, 
            v1975("pitch", true)
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].pitch_delay:depend({
            [1] = nil, 
            [2] = "Switch", 
            [1] = l_v1399_0[v1919][v1918].pitch
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].pitch_speed:depend({
            [1] = nil, 
            [2] = "Spin", 
            [3] = "Sway", 
            [1] = l_v1399_0[v1919][v1918].pitch
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].pitch_ways_count:depend({
            [1] = nil, 
            [2] = "Ways", 
            [1] = l_v1399_0[v1919][v1918].pitch
        }, unpack(v1970));
        l_v1399_0[v1919][v1918].pitch_ways:depend({
            [1] = nil, 
            [2] = "Ways", 
            [1] = l_v1399_0[v1919][v1918].pitch
        }, l_v1399_0[v1919][v1918].pitch.custom_ways, unpack(v1970));
        l_v1399_0[v1919][v1918].custom_tickbase:depend(l_v1399_0[v1919][v1918].force_break_lc, unpack(v1970));
        l_v1399_0[v1919][v1918].duration:depend(unpack(v1970));
        for v1976, v1977 in pairs(l_v1399_0[v1919][v1918]) do
            if v1976 ~= "custom_tickbase" and v1976 ~= "force_break_lc" and v1976 ~= "enable" then
                v1977:depend(true, {
                    [1] = nil, 
                    [2] = false, 
                    [1] = l_v1397_3.unmatched_features.disable_defensive
                });
            end;
        end;
    end;
    for _, v1979 in ipairs(v1405) do
        for _, v1981 in ipairs(l_v1408_1) do
            v1414(v1979, v1981);
        end;
    end;
    l_v1415_1 = {
        names = {}, 
        callbacks = {}, 
        create = function(v1982, v1983, v1984)
            table.insert(v1982.names, v1983);
            v1982.callbacks[v1983] = v1984;
        end
    };
    l_v1415_1:create(l_v1403_1);
    l_v1415_1:create("On use", function(_)
        -- upvalues: l_v1396_2 (ref)
        return l_v1396_2;
    end);
    l_v1415_1:create("Stand", function(v1986, v1987, v1988, v1989)
        local v1990;
        if v1989 >= 2 or v1986 or not v1987 or v1988 >= 0.7 then
            v1990 = false;
        else
            v1990 = true;
        end;
        return v1990;
    end);
    l_v1415_1:create("Air crouch", function(v1991, v1992, v1993, _)
        return v1993 > 0.8 and (v1991 or not v1992);
    end);
    l_v1415_1:create("Air", function(v1995, v1996, v1997, _)
        return v1997 < 0.8 and (v1995 or not v1996);
    end);
    l_v1415_1:create("Creeping", function(v1999, v2000, v2001, v2002)
        local v2003;
        if v2001 <= 0.8 or v1999 or not v2000 or v2002 <= 2 then
            v2003 = false;
        else
            v2003 = true;
        end;
        return v2003;
    end);
    l_v1415_1:create("Crouch", function(v2004, v2005, v2006, v2007)
        local v2008;
        if v2006 <= 0.8 or v2004 or not v2005 or v2007 >= 2 then
            v2008 = false;
        else
            v2008 = true;
        end;
        return v2008;
    end);
    l_v1415_1:create("Run", function(v2009, v2010, v2011, v2012)
        -- upvalues: v265 (ref)
        local v2013;
        if v2012 <= 2 or v2009 or not v2010 or v265.is_slow_walk or v2011 >= 0.7 then
            v2013 = false;
        else
            v2013 = true;
        end;
        return v2013;
    end);
    l_v1415_1:create("Walk", function(v2014, v2015, v2016, _)
        -- upvalues: v265 (ref)
        local l_is_slow_walk_0 = v265.is_slow_walk;
        if l_is_slow_walk_0 then
            if v2014 or not v2015 or v2016 >= 0.7 then
                l_is_slow_walk_0 = false;
            else
                l_is_slow_walk_0 = true;
            end;
        end;
        return l_is_slow_walk_0;
    end);
    l_v1416_0 = {
        names = {}, 
        callbacks = {}, 
        create = function(v2019, v2020, v2021)
            table.insert(v2019.names, v2020);
            v2019.callbacks[v2020] = v2021;
        end
    };
    l_v1416_0:create("On peek", function(_, _, _, _)
        -- upvalues: v265 (ref)
        return v265.on_peek;
    end);
    l_v1416_0:create("Stand", function(v2026, v2027, v2028, v2029)
        local v2030;
        if v2029 >= 2 or v2026 or not v2027 or v2028 >= 0.7 then
            v2030 = false;
        else
            v2030 = true;
        end;
        return v2030;
    end);
    l_v1416_0:create("Air crouch", function(v2031, v2032, v2033, _)
        return v2033 > 0.8 and (v2031 or not v2032);
    end);
    l_v1416_0:create("Air", function(v2035, v2036, v2037, _)
        return v2037 < 0.8 and (v2035 or not v2036);
    end);
    l_v1416_0:create("Creeping", function(v2039, v2040, v2041, v2042)
        local v2043;
        if v2041 <= 0.8 or v2039 or not v2040 or v2042 <= 2 then
            v2043 = false;
        else
            v2043 = true;
        end;
        return v2043;
    end);
    l_v1416_0:create("Crouch", function(v2044, v2045, v2046, v2047)
        local v2048;
        if v2046 <= 0.8 or v2044 or not v2045 or v2047 >= 2 then
            v2048 = false;
        else
            v2048 = true;
        end;
        return v2048;
    end);
    l_v1416_0:create("Run", function(v2049, v2050, v2051, v2052)
        -- upvalues: v265 (ref)
        local v2053;
        if v2052 <= 2 or v2049 or not v2050 or v265.is_slow_walk or v2051 >= 0.7 then
            v2053 = false;
        else
            v2053 = true;
        end;
        return v2053;
    end);
    l_v1416_0:create("Walk", function(v2054, v2055, v2056, _)
        -- upvalues: v265 (ref)
        local l_is_slow_walk_1 = v265.is_slow_walk;
        if l_is_slow_walk_1 then
            if v2054 or not v2055 or v2056 >= 0.7 then
                l_is_slow_walk_1 = false;
            else
                l_is_slow_walk_1 = true;
            end;
        end;
        return l_is_slow_walk_1;
    end);
    l_v1417_1 = function(v2059, v2060, v2061)
        if v2061 == 0 then
            return true;
        elseif not v2059 or not v2060 or v2060:is_dormant() then
            return;
        else
            local v2062 = v2059:get_origin();
            local v2063 = v2060:get_origin();
            return v2062.z ~= nil and v2063.z ~= nil and v2062.z - v2061 > v2063.z;
        end;
    end;
    l_v1418_0 = false;
    l_v1419_1 = function(v2064)
        -- upvalues: l_v1418_0 (ref), v265 (ref), l_v1397_3 (ref), l_v1417_1 (ref)
        l_v1418_0 = false;
        local l_me_20 = v265.me;
        local l_weapon_7 = v265.weapon;
        local l_threat_1 = v265.threat;
        local l_is_alive_1 = v265.is_alive;
        local l_anim_state_5 = v265.anim_state;
        local l_safe_head_0 = l_v1397_3.safe_head;
        if not l_safe_head_0.value or not l_me_20 or not l_is_alive_1 or not l_weapon_7 or not l_anim_state_5 or not l_threat_1 then
            return;
        else
            local l_on_ground_0 = l_anim_state_5.on_ground;
            local v2072 = l_weapon_7:get_classname();
            local v2073 = v2072 == "CWeaponTaser" and l_safe_head_0.options:get(1);
            local v2074 = v2072 == "CKnife" and l_safe_head_0.options:get(2);
            local v2075 = l_safe_head_0.options:get(3) and v2072 ~= nil;
            local v2076 = l_v1417_1(l_me_20, l_threat_1, l_safe_head_0.height_difference.value);
            if l_safe_head_0.states:get(1) and (v2076 and v2075 or v2074 or v2073) and (v2064.in_jump or not l_on_ground_0) then
                l_v1418_0 = true;
                return;
            elseif l_safe_head_0.states:get(2) and v2076 and l_on_ground_0 and not v2064.in_duck and v265.velocity < 2 then
                l_v1418_0 = true;
                return;
            elseif l_safe_head_0.states:get(3) and v2076 and l_on_ground_0 and v2064.in_duck then
                l_v1418_0 = true;
                return;
            else
                return;
            end;
        end;
    end;
    l_v1420_1 = function()
        -- upvalues: v265 (ref)
        local l_me_21 = v265.me;
        local l_eye_3 = v265.eye;
        local l_weapon_8 = v265.weapon;
        local l_camera_angles_2 = v265.camera_angles;
        if not l_me_21 or not l_eye_3 or not l_weapon_8 or not l_camera_angles_2 then
            return;
        elseif l_weapon_8:get_classname() == "CC4" then
            return true;
        else
            local v2081 = vector():angles(l_camera_angles_2);
            local v2082 = utils.trace_line(l_eye_3, l_eye_3 + v2081 * 200, l_me_21, 1174421515);
            if v2082.entity ~= nil then
                local v2083 = string.lower(v2082.entity:get_classname());
                if v2083:match("weapon") or v2083:match("deagle") or v2083:match("door") or v2083:match("button") or v2083:match("cphysicsprop") then
                    return true;
                end;
            end;
            if l_me_21.m_iTeamNum ~= 3 then
                return false;
            else
                local v2084 = {
                    [1] = 1337
                };
                entity.get_entities("CHostage", false, function(v2085)
                    -- upvalues: v2084 (ref), l_eye_3 (ref)
                    if v2085.m_nHostageState ~= 3 then
                        table.insert(v2084, v2085.m_vecOrigin:dist(l_eye_3));
                    end;
                end);
                entity.get_entities("CPlantedC4", false, function(v2086)
                    -- upvalues: v2084 (ref), l_eye_3 (ref)
                    table.insert(v2084, v2086.m_vecOrigin:dist(l_eye_3));
                end);
                if math.min(unpack(v2084)) < 125 then
                    return true;
                else
                    return false;
                end;
            end;
        end;
    end;
    l_v1421_1 = function(v2087)
        -- upvalues: v51 (ref), l_v1396_2 (ref), l_v1397_3 (ref), l_v1420_1 (ref)
        local v2088 = v51.find("drop_grenades");
        l_v1396_2 = l_v1397_3.allow_on_use.value and (not v2088 or not v2088.value) and not l_v1420_1() and v2087.in_use;
        if l_v1396_2 then
            v2087.in_use = false;
        end;
    end;
    l_v1422_1 = function()
        -- upvalues: v52 (ref), l_v1397_3 (ref)
        v52.avoid_backstab:override(l_v1397_3.avoid_backstab.value);
    end;
    local function v2091(v2089, v2090)
        v2089:override(v2090());
    end;
    local v2092 = 1;
    local v2093 = 1;
    local v2094 = false;
    local v2095 = 1;
    local v2096 = 0;
    local v2097 = 0;
    local v2098 = 1;
    local v2099 = false;
    local v2100 = false;
    local v2101 = false;
    local v2102 = false;
    local v2103 = 0;
    local v2104 = 0;
    local v2105 = 0;
    local v2106 = 0;
    local function v2163(_, v2108, v2109)
        -- upvalues: l_v1398_2 (ref), v2093 (ref), v2095 (ref), v2094 (ref), v2097 (ref), v2096 (ref), v2105 (ref), v2106 (ref), v2092 (ref), v2102 (ref), l_v1397_3 (ref), l_v1396_2 (ref), v265 (ref), l_v1412_0 (ref), v2103 (ref), l_v1409_1 (ref), v2100 (ref), v52 (ref), v2101 (ref), l_v1418_0 (ref), v2098 (ref), v2099 (ref), v2091 (ref), v2104 (ref), v35 (ref), l_v1410_1 (ref), l_v1411_0 (ref)
        local v2110 = rage.antiaim:inverter();
        local l_choked_commands_0 = globals.choked_commands;
        local l_value_23 = l_v1398_2[v2109][v2108].ways_count.value;
        if l_choked_commands_0 == 0 then
            local v2113 = 0;
            local l_delay_0 = l_v1398_2[v2109][v2108].delay;
            if l_delay_0.value then
                local l_value_24 = l_delay_0.mode.value;
                if l_value_24 == 1 then
                    v2113 = l_delay_0.static.value;
                end;
                if l_value_24 == 2 then
                    if v2093 == 1 then
                        if v2095 >= l_delay_0.stages_count.value then
                            v2095 = 0;
                        end;
                        v2095 = v2095 + 1;
                    end;
                    v2113 = l_delay_0[tostring(v2095)].value;
                end;
                if l_value_24 == 3 then
                    if l_delay_0.min_max_sides.value then
                        if v2093 == 1 then
                            if v2094 then
                                v2097 = math.random(l_delay_0.right_min.value, l_delay_0.right_max.value);
                            else
                                v2097 = math.random(l_delay_0.left_min.value, l_delay_0.left_max.value);
                            end;
                        end;
                        v2113 = v2097;
                    else
                        v2113 = v2094 and l_delay_0.right.value or l_delay_0.left.value;
                    end;
                end;
                if l_value_24 == 4 then
                    if v2093 == 1 then
                        v2096 = math.random(l_delay_0.min.value, l_delay_0.max.value);
                    end;
                    v2113 = v2096;
                end;
            end;
            local l_freeze_inverter_0 = l_v1398_2[v2109][v2108].freeze_inverter;
            if l_freeze_inverter_0.value then
                if v2105 == 0 then
                    if math.random(0, 100) < l_freeze_inverter_0.chance.value then
                        v2106 = l_freeze_inverter_0.duration.value;
                    else
                        v2106 = 0;
                    end;
                end;
                if v2106 <= v2105 then
                    v2105 = 0;
                else
                    v2105 = v2105 + 1;
                end;
            else
                v2105 = 0;
                v2106 = 0;
            end;
            if v2105 <= 0 then
                if v2113 > 1 then
                    if v2113 <= v2093 then
                        v2093 = 1;
                        v2094 = not v2094;
                    else
                        v2093 = v2093 + 1;
                    end;
                else
                    v2093 = 1;
                    v2094 = not v2094;
                end;
            end;
            if l_value_23 <= v2092 then
                v2092 = 0;
            end;
            v2092 = v2092 + 1;
        end;
        local v2117 = 0;
        local v2118 = "Down";
        v2102 = false;
        local l_unsafe_yaw_0 = l_v1397_3.unsafe_yaw;
        if l_unsafe_yaw_0.value and not l_v1396_2 then
            if l_unsafe_yaw_0.events:get(2) then
                local v2120 = 0;
                for _, v2122 in ipairs(v265.players) do
                    if v2122.is_enemy and v2122.is_alive then
                        v2120 = v2120 + 1;
                    end;
                end;
                v2102 = v2120 == 0;
            end;
            if l_unsafe_yaw_0.events:get(1) and v265.is_warmup then
                v2102 = true;
            end;
            if v2102 then
                local l_value_25 = l_unsafe_yaw_0.yaw.value;
                if l_value_25 == 1 then
                    v2117 = l_v1412_0(1, -180, 180);
                end;
                if l_value_25 == 2 then
                    v2117 = math.random(-180, 180);
                end;
                local l_value_26 = l_unsafe_yaw_0.pitch.value;
                if l_value_26 == 1 then
                    v2118 = "Disabled";
                end;
                if l_value_26 == 2 then
                    v2118 = "Down";
                end;
            end;
        end;
        l_unsafe_yaw_0 = l_v1398_2[v2109][v2108].force_disable;
        local v2125 = l_unsafe_yaw_0:get(1);
        local v2126 = l_unsafe_yaw_0:get(2);
        local l_value_27 = l_v1397_3.manual.value;
        v2103 = l_v1409_1[l_value_27] or 0;
        v2100 = v2103 ~= 0;
        local v2128 = l_value_27 == "Left" or l_value_27 == "Right";
        local l_value_28 = l_v1397_3.manual.static.value;
        if v2125 then
            v2103 = 0;
            v2100 = false;
            v2128 = false;
        end;
        local l_value_29 = l_v1397_3.freestanding.value;
        local l_value_30 = l_v1397_3.freestanding.static.value;
        if l_value_29 and not v2126 and not v2100 and not l_v1396_2 and not v52.freestanding:get() then
            v52.freestanding:override(true);
            v52.freestanding.yaw:override(l_value_30);
            v52.freestanding.body:override(l_value_30);
        else
            v52.freestanding:override();
        end;
        v2101 = l_v1418_0 and not v2100 and not l_v1396_2;
        local l_desync_0 = l_v1398_2[v2109][v2108].desync;
        local l_value_31 = l_desync_0.desync_state.value;
        local v2134 = l_desync_0.limits_value.value == 1;
        if l_desync_0.value and l_value_31 == 3 then
            if l_desync_0.delay.value <= v2098 then
                v2098 = 1;
                v2099 = not v2099;
            else
                v2098 = v2098 + 1;
            end;
        end;
        do
            local l_l_desync_0_0, l_l_value_31_0, l_v2134_0 = l_desync_0, l_value_31, v2134;
            v2091(v52.antiaim.desync, function()
                -- upvalues: v2102 (ref), v2101 (ref), l_l_desync_0_0 (ref), l_l_value_31_0 (ref), v2099 (ref)
                if v2102 then
                    return false;
                elseif v2101 then
                    return true;
                elseif not l_l_desync_0_0.value then
                    return false;
                elseif l_l_value_31_0 == 2 then
                    return math.random(0, 2) == 0;
                elseif l_l_value_31_0 == 3 then
                    return v2099;
                else
                    return true;
                end;
            end);
            local v2138 = 0;
            if not l_v2134_0 then
                v2138 = math.random(l_v1398_2[v2109][v2108].limit_min.value, l_v1398_2[v2109][v2108].limit_max.value);
            end;
            v2091(v52.antiaim.left_limit, function()
                -- upvalues: v2101 (ref), l_v2134_0 (ref), l_v1398_2 (ref), v2109 (ref), v2108 (ref), v2138 (ref)
                if v2101 then
                    return 5;
                else
                    return l_v2134_0 and l_v1398_2[v2109][v2108].left_limit.value or v2138;
                end;
            end);
            v2091(v52.antiaim.right_limit, function()
                -- upvalues: v2101 (ref), l_v2134_0 (ref), l_v1398_2 (ref), v2109 (ref), v2108 (ref), v2138 (ref)
                if v2101 then
                    return 5;
                else
                    return l_v2134_0 and l_v1398_2[v2109][v2108].right_limit.value or v2138;
                end;
            end);
        end;
        v2091(v52.antiaim.enabled, function()
            return true;
        end);
        v2091(v52.antiaim.base, function()
            -- upvalues: v2101 (ref), l_v1396_2 (ref), v2100 (ref), l_v1397_3 (ref)
            if v2101 then
                return "at target";
            elseif l_v1396_2 or v2100 then
                return "local view";
            else
                return l_v1397_3.view.value;
            end;
        end);
        v2091(v52.antiaim.yaw, function()
            return "backward";
        end);
        v2091(v52.antiaim.modifier, function()
            return "disabled";
        end);
        v2091(v52.antiaim.pitch, function()
            -- upvalues: v2102 (ref), v2118 (ref), l_v1396_2 (ref)
            if v2102 then
                return v2118;
            else
                return l_v1396_2 and "disabled" or "down";
            end;
        end);
        l_desync_0 = l_v1398_2[v2109][v2108].options;
        do
            local l_l_desync_0_1 = l_desync_0;
            v2091(v52.antiaim.inverter, function()
                -- upvalues: v2101 (ref), l_value_29 (ref), l_value_30 (ref), v2128 (ref), l_value_28 (ref), l_l_desync_0_1 (ref), v2094 (ref)
                if v2101 then
                    return true;
                elseif (not l_value_29 or not l_value_30) and (not v2128 or not l_value_28) and l_l_desync_0_1.jitter.value then
                    return v2094;
                else
                    return l_l_desync_0_1.inverter.value;
                end;
            end);
            v2091(v52.antiaim.freestanding, function()
                -- upvalues: l_l_desync_0_1 (ref)
                return l_l_desync_0_1.freestanding.value;
            end);
            v2091(v52.antiaim.options, function()
                return {};
            end);
        end;
        v2091(v52.antiaim.offset, function()
            -- upvalues: v2104 (ref), v2102 (ref), v2117 (ref), v2101 (ref), l_v1398_2 (ref), v2109 (ref), v2108 (ref), v2110 (ref), v2094 (ref), v35 (ref), v2092 (ref), l_value_23 (ref), l_v1410_1 (ref), l_v1412_0 (ref), l_v1411_0 (ref), l_v1396_2 (ref), v2128 (ref), l_value_28 (ref), v2103 (ref)
            v2104 = 0;
            if v2102 then
                return v2117;
            elseif v2101 then
                return 0;
            else
                local l_offset_1 = l_v1398_2[v2109][v2108].offset;
                local l_value_32 = l_offset_1.value;
                local l_value_33 = l_offset_1.add_sides.value;
                local l_value_34 = l_offset_1.add_random.value;
                local l_value_35 = l_v1398_2[v2109][v2108].offset_add_left.value;
                local l_value_36 = l_v1398_2[v2109][v2108].offset_add_right.value;
                local l_value_37 = l_v1398_2[v2109][v2108].offset_add_random.value;
                local l_l_value_32_0 = l_value_32;
                if l_value_33 then
                    l_l_value_32_0 = l_l_value_32_0 + (v2110 and l_value_36 or l_value_35);
                end;
                if l_value_34 then
                    l_l_value_32_0 = l_l_value_32_0 + math.random(-l_value_37, l_value_37);
                end;
                local l_modifier_0 = l_v1398_2[v2109][v2108].modifier;
                local l_value_38 = l_modifier_0.value;
                local l_value_39 = l_modifier_0.min_max.value;
                local l_value_40 = l_modifier_0.custom_ways.value;
                local l_value_41 = l_modifier_0.apply_delay.value;
                local l_value_42 = l_v1398_2[v2109][v2108].speed.value;
                local l_value_43 = l_v1398_2[v2109][v2108].degree.value;
                local v2155 = l_value_39 and l_v1398_2[v2109][v2108].degree_min.value or l_value_43;
                local v2156 = l_value_39 and l_v1398_2[v2109][v2108].degree_max.value or -l_value_43;
                local l_ways_0 = l_v1398_2[v2109][v2108].ways;
                local v2158 = 0;
                local v2159 = globals.tickcount % 4 >= 2;
                if l_value_41 then
                    v2159 = v2094;
                end;
                if l_value_38 == "Center" then
                    v2158 = v2159 and v2155 or v2156;
                end;
                if l_value_38 == "Offset" then
                    if l_value_39 then
                        v2158 = v2159 and v2155 or v2156;
                    else
                        v2158 = v2159 and v2155 or 0;
                    end;
                end;
                if l_value_38 == "Random" then
                    v2158 = math.random(v2155, v2156);
                end;
                if l_value_38 == "Ways" then
                    if l_value_40 then
                        local v2160 = v35(v2092, 1, l_value_23);
                        local v2161 = l_ways_0[tostring(v2160)];
                        if v2161 then
                            v2158 = v2161.value;
                        end;
                    else
                        local v2162 = l_v1410_1(l_value_23, v2155, v2156)[v35(v2092, 1, l_value_23)];
                        if v2162 then
                            v2158 = v2162;
                        end;
                    end;
                end;
                if l_value_38 == "Spin" then
                    v2158 = l_v1412_0(l_value_42 / 100, v2155, v2156);
                end;
                if l_value_38 == "Sway" then
                    v2158 = l_v1411_0(l_value_42 / 100, v2155, v2156);
                end;
                v2104 = l_l_value_32_0 + v2158;
                if l_v1396_2 then
                    return l_l_value_32_0 + v2158 + 180;
                elseif v2128 and l_value_28 then
                    return l_l_value_32_0 + v2103;
                else
                    return l_l_value_32_0 + v2158 + v2103;
                end;
            end;
        end);
    end;
    local v2164 = 0;
    local function _(v2165, v2166, v2167)
        return v2165 % v2166[v2167 and math.random(1, #v2166) or (v2165 - 1) % #v2166 + 1] == 0;
    end;
    local v2169 = false;
    local v2170 = 0;
    local v2171 = 1;
    local v2172 = 1;
    local v2173 = 1;
    local v2174 = 1;
    local v2175 = false;
    local v2176 = 1;
    local v2177 = false;
    local v2178 = 1;
    local v2179 = false;
    local v2180 = 1;
    local v2181 = 1;
    local function v2226(v2182, v2183, v2184)
        -- upvalues: l_v1399_0 (ref), v2102 (ref), l_v1396_2 (ref), v2101 (ref), v2100 (ref), v2091 (ref), v52 (ref), l_v1397_3 (ref), v265 (ref), v2164 (ref), v2180 (ref), v2181 (ref), v2170 (ref), v2169 (ref), v2176 (ref), v2177 (ref), l_v1412_0 (ref), l_v1411_0 (ref), v2172 (ref), v35 (ref), l_v1410_1 (ref), v2103 (ref), v2174 (ref), v2175 (ref), v2171 (ref), v2178 (ref), v2179 (ref), v2173 (ref), v2104 (ref)
        local l_choked_commands_1 = globals.choked_commands;
        local v2186 = v2183 ~= nil and l_v1399_0[v2184][v2183].force_break_lc;
        local v2187 = v2183 ~= nil and v2186.value and not v2102 and not l_v1396_2 and not v2101 and not v2100;
        v2091(v52.double_tap.options, function()
            -- upvalues: v2187 (ref), v2186 (ref)
            return v2187 and v2186.allow_double_tap.value and "always on" or nil;
        end);
        v2091(v52.hide_shots.options, function()
            -- upvalues: v2187 (ref), v2186 (ref)
            return v2187 and v2186.allow_hide_shots.value and "break lc" or nil;
        end);
        v2091(v52.antiaim.hidden, function()
            -- upvalues: v2183 (ref), l_v1397_3 (ref)
            return v2183 ~= nil and not l_v1397_3.unmatched_features.disable_defensive.value;
        end);
        if not v2183 then
            return;
        else
            local l_custom_tickbase_0 = l_v1399_0[v2184][v2183].custom_tickbase;
            local l_value_44 = l_custom_tickbase_0.value;
            local l_value_45 = l_custom_tickbase_0.static.value;
            if v2187 and l_value_44 then
                v2182.force_defensive = v2182.command_number % l_value_45 == 0;
            end;
            if v265.is_defensive then
                v2164 = v2164 + 1;
            else
                v2164 = 0;
            end;
            local v2191 = true;
            local l_duration_0 = l_v1399_0[v2184][v2183].duration;
            if l_duration_0.value then
                local l_value_46 = l_duration_0.mode.value;
                local v2194 = nil;
                if l_value_46 == 1 then
                    v2194 = l_duration_0.static.value;
                end;
                if l_value_46 == 2 then
                    local l_value_47 = l_duration_0.stages_count.value;
                    if v2164 == 1 then
                        if l_value_47 <= v2180 then
                            v2180 = 0;
                        end;
                        v2180 = v2180 + 1;
                    end;
                    v2194 = l_duration_0[tostring(v2180)].value;
                end;
                if l_value_46 == 3 then
                    if v2164 == 1 then
                        v2181 = math.random(l_duration_0.min.value, l_duration_0.max.value);
                    end;
                    v2194 = v2181;
                end;
                if v2194 ~= nil then
                    v2191 = v2164 <= v2194 and v2164 ~= 0;
                end;
            end;
            l_duration_0 = nil;
            local l_pitch_0 = l_v1399_0[v2184][v2183].pitch;
            local l_value_48 = l_pitch_0.value;
            local l_value_49 = l_pitch_0.min_max.value;
            local l_value_50 = l_pitch_0.custom_ways.value;
            local l_value_51 = l_v1399_0[v2184][v2183].pitch_degree.value;
            local v2201 = l_value_49 and l_v1399_0[v2184][v2183].pitch_degree_min.value or -l_value_51;
            local v2202 = l_value_49 and l_v1399_0[v2184][v2183].pitch_degree_max.value or l_value_51;
            local l_value_52 = l_v1399_0[v2184][v2183].pitch_ways_count.value;
            local l_pitch_ways_0 = l_v1399_0[v2184][v2183].pitch_ways;
            if l_value_48 == "Static" then
                l_duration_0 = l_value_51;
            end;
            if l_value_48 == "Swap" then
                if v2164 == 0 and v2170 ~= 0 then
                    v2169 = not v2169;
                end;
                v2170 = v2164;
                l_duration_0 = v2169 and v2201 or v2202;
            end;
            if l_value_48 == "Switch" then
                local l_value_53 = l_v1399_0[v2184][v2183].pitch_delay.value;
                if l_choked_commands_1 == 0 then
                    if l_value_53 > 1 then
                        if l_value_53 <= v2176 then
                            v2176 = 1;
                            v2177 = not v2177;
                        else
                            v2176 = v2176 + 1;
                        end;
                    else
                        v2176 = 1;
                        v2177 = not v2177;
                    end;
                end;
                l_duration_0 = v2177 and v2201 or v2202;
            end;
            if l_value_48 == "Random" then
                l_duration_0 = math.random(v2201, v2202);
            end;
            if l_value_48 == "Spin" then
                local l_value_54 = l_v1399_0[v2184][v2183].pitch_speed.value;
                l_duration_0 = l_v1412_0(l_value_54 / 100, v2201, v2202);
            end;
            if l_value_48 == "Sway" then
                local l_value_55 = l_v1399_0[v2184][v2183].pitch_speed.value;
                l_duration_0 = l_v1411_0(l_value_55 / 100, v2201, v2202);
            end;
            if l_value_48 == "Ways" then
                if l_choked_commands_1 == 0 then
                    if l_value_52 <= v2172 then
                        v2172 = 0;
                    end;
                    v2172 = v2172 + 1;
                end;
                if l_value_50 then
                    local v2208 = v35(v2172, 1, l_value_52);
                    local v2209 = l_pitch_ways_0[tostring(v2208)];
                    if v2209 then
                        l_duration_0 = v2209.value;
                    end;
                else
                    local v2210 = l_v1410_1(l_value_52, v2201, v2202);
                    local v2211 = v35(v2172, 1, l_value_52);
                    if v2210[v2211] then
                        l_duration_0 = v2210[v2211];
                    end;
                end;
            end;
            if v2191 and l_duration_0 then
                rage.antiaim:override_hidden_pitch(l_duration_0);
            end;
            l_duration_0 = 0;
            l_pitch_0 = l_v1399_0[v2184][v2183].yaw;
            l_value_48 = l_pitch_0.value;
            l_value_49 = l_pitch_0.min_max.value;
            l_value_50 = l_pitch_0.custom_ways.value;
            l_value_51 = l_v1399_0[v2184][v2183].yaw_degree.value;
            v2201 = l_value_49 and l_v1399_0[v2184][v2183].yaw_degree_min.value or -l_value_51;
            v2202 = l_value_49 and l_v1399_0[v2184][v2183].yaw_degree_max.value or l_value_51;
            print();
            l_value_52 = l_v1399_0[v2184][v2183].yaw_ways_count.value;
            l_pitch_ways_0 = l_v1399_0[v2184][v2183].yaw_ways;
            if l_value_48 == "Static" then
                l_duration_0 = l_value_51;
            end;
            if l_value_48 == "Peek direction" and v265.peek_yaw then
                l_duration_0 = v265.peek_yaw - v2103;
            end;
            if l_value_48 == "Swap" then
                if v2164 == 0 and v2170 ~= 0 then
                    v2169 = not v2169;
                end;
                v2170 = v2164;
                l_duration_0 = v2169 and v2201 or v2202;
            end;
            if l_value_48 == "Switch" then
                local l_value_56 = l_v1399_0[v2184][v2183].yaw_delay.value;
                if l_choked_commands_1 == 0 then
                    if l_value_56 > 1 then
                        if l_value_56 <= v2174 then
                            v2174 = 1;
                            v2175 = not v2175;
                        else
                            v2174 = v2174 + 1;
                        end;
                    else
                        v2174 = 1;
                        v2175 = not v2175;
                    end;
                end;
                l_duration_0 = v2175 and v2201 or v2202;
            end;
            if l_value_48 == "Random" then
                l_duration_0 = math.random(v2201, v2202);
            end;
            if l_value_48 == "Spin" then
                local l_value_57 = l_v1399_0[v2184][v2183].yaw_speed.value;
                l_duration_0 = l_v1412_0(l_value_57 / 100, v2201, v2202);
            end;
            if l_value_48 == "Sway" then
                local l_value_58 = l_v1399_0[v2184][v2183].yaw_speed.value;
                l_duration_0 = l_v1411_0(l_value_58 / 100, v2201, v2202);
            end;
            if l_value_48 == "Ways" then
                if l_choked_commands_1 == 0 then
                    if l_value_52 <= v2171 then
                        v2171 = 0;
                    end;
                    v2171 = v2171 + 1;
                end;
                if l_value_50 then
                    local v2215 = v35(v2171, 1, l_value_52);
                    local v2216 = l_pitch_ways_0[tostring(v2215)];
                    if v2216 then
                        l_duration_0 = v2216.value;
                    end;
                else
                    local v2217 = l_v1410_1(l_value_52, v2201, v2202);
                    local v2218 = v35(v2171, 1, l_value_52);
                    if v2217[v2218] then
                        l_duration_0 = v2217[v2218];
                    end;
                end;
            end;
            l_pitch_0 = l_v1399_0[v2184][v2183].modifier;
            l_value_48 = l_pitch_0.value;
            l_value_49 = l_pitch_0.min_max.value;
            l_value_50 = l_pitch_0.custom_ways.value;
            l_value_51 = l_v1399_0[v2184][v2183].modifier_degree.value;
            v2201 = l_value_49 and l_v1399_0[v2184][v2183].modifier_degree_min.value or -l_value_51;
            v2202 = l_value_49 and l_v1399_0[v2184][v2183].modifier_degree_max.value or l_value_51;
            l_value_52 = l_v1399_0[v2184][v2183].modifier_ways_count.value;
            l_pitch_ways_0 = l_v1399_0[v2184][v2183].modifier_ways;
            if l_value_48 == "Static" then
                l_duration_0 = l_duration_0 + l_value_51;
            end;
            if yaw == "Peek direction" and v265.peek_yaw then
                l_duration_0 = l_duration_0 + v265.peek_yaw - v2103;
            end;
            if l_value_48 == "Swap" then
                if v2164 == 0 and v2170 ~= 0 then
                    v2169 = not v2169;
                end;
                v2170 = v2164;
                l_duration_0 = l_duration_0 + (v2169 and v2201 or v2202);
            end;
            if l_value_48 == "Switch" then
                local l_value_59 = l_v1399_0[v2184][v2183].modifier_delay.value;
                if l_choked_commands_1 == 0 then
                    if l_value_59 > 1 then
                        if l_value_59 <= v2178 then
                            v2178 = 1;
                            v2179 = not v2179;
                        else
                            v2178 = v2178 + 1;
                        end;
                    else
                        v2178 = 1;
                        v2179 = not v2179;
                    end;
                end;
                l_duration_0 = l_duration_0 + (v2179 and v2201 or v2202);
            end;
            if l_value_48 == "Random" then
                l_duration_0 = l_duration_0 + math.random(v2201, v2202);
            end;
            if l_value_48 == "Spin" then
                local l_value_60 = l_v1399_0[v2184][v2183].modifier_speed.value;
                l_duration_0 = l_duration_0 + l_v1412_0(l_value_60 / 100, v2201, v2202);
            end;
            if l_value_48 == "Sway" then
                local l_value_61 = l_v1399_0[v2184][v2183].modifier_speed.value;
                l_duration_0 = l_duration_0 + l_v1411_0(l_value_61 / 100, v2201, v2202);
            end;
            if l_value_48 == "Ways" then
                if l_choked_commands_1 == 0 then
                    if l_value_52 <= v2173 then
                        v2173 = 0;
                    end;
                    v2173 = v2173 + 1;
                end;
                if l_value_50 then
                    local v2222 = v35(v2173, 1, l_value_52);
                    local v2223 = l_pitch_ways_0[tostring(v2222)];
                    if v2223 then
                        l_duration_0 = l_duration_0 + v2223.value;
                    end;
                else
                    local v2224 = l_v1410_1(l_value_52, v2201, v2202);
                    local v2225 = v35(v2173, 1, l_value_52);
                    if v2224[v2225] then
                        l_duration_0 = l_duration_0 + v2224[v2225];
                    end;
                end;
            end;
            if l_v1399_0[v2184][v2183].enable.remove_modifier.value then
                l_duration_0 = l_duration_0 - v2104;
            end;
            rage.antiaim:override_hidden_yaw_offset(v2191 and -l_duration_0 or 0);
            return;
        end;
    end;
    local function v2250(v2227)
        -- upvalues: v265 (ref), l_v1397_3 (ref), l_v1408_1 (ref), l_v1403_1 (ref), l_v1415_1 (ref), l_v1398_2 (ref), l_v1419_1 (ref), l_v1421_1 (ref), l_v1422_1 (ref), v2163 (ref), l_v1416_0 (ref), l_v1399_0 (ref), v2226 (ref)
        local l_me_22 = v265.me;
        local l_velocity_2 = v265.velocity;
        local l_anim_state_6 = v265.anim_state;
        if not l_me_22 or not l_velocity_2 or not l_anim_state_6 then
            return;
        else
            local l_in_jump_0 = v2227.in_jump;
            local l_m_iTeamNum_0 = l_me_22.m_iTeamNum;
            local l_on_ground_1 = l_anim_state_6.on_ground;
            local l_anim_duck_amount_0 = l_anim_state_6.anim_duck_amount;
            local l_value_62 = l_v1397_3.state.use_teams.value;
            local l_value_63 = l_v1397_3.defensive_state.use_teams.value;
            local v2237 = l_m_iTeamNum_0 == 2 and l_v1408_1[2] or l_v1408_1[3];
            local v2238 = l_value_62 and v2237 or l_v1408_1[1];
            local v2239 = l_value_63 and v2237 or l_v1408_1[1];
            local l_l_v1403_1_0 = l_v1403_1;
            for _, v2242 in ipairs(l_v1415_1.names) do
                local v2243 = l_v1415_1.callbacks[v2242];
                local v2244 = l_v1398_2[v2238][v2242] and l_v1398_2[v2238][v2242].enable and l_v1398_2[v2238][v2242].enable.value;
                if v2243 and v2243(l_in_jump_0, l_on_ground_1, l_anim_duck_amount_0, l_velocity_2) and v2244 then
                    l_l_v1403_1_0 = v2242;
                    break;
                end;
            end;
            l_v1419_1(v2227);
            l_v1421_1(v2227);
            l_v1422_1();
            v2163(v2227, l_l_v1403_1_0, v2238);
            local v2245 = nil;
            for _, v2247 in ipairs(l_v1416_0.names) do
                local v2248 = l_v1416_0.callbacks[v2247];
                local v2249 = l_v1399_0[v2239][v2247] and l_v1399_0[v2239][v2247].enable and l_v1399_0[v2239][v2247].enable.value;
                if v2248 and v2248(l_in_jump_0, l_on_ground_1, l_anim_duck_amount_0, l_velocity_2) and v2249 then
                    v2245 = v2247;
                    break;
                end;
            end;
            v2226(v2227, v2245, v2239);
            return;
        end;
    end;
    events.createmove(v2250);
    v1395 = {
        states = l_v1398_2, 
        elements = l_v1397_3, 
        defensive_states = l_v1399_0
    };
end;
v225.package = l_pui_0.setup({
    antiaim = v1395, 
    features = v51.get_storage()
}, true);
v1396 = nil;
l_pui_0.sidebar("evalate 2", "signal-stream");
print(v9:stop(), "ms");