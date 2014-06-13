package com.springapp.demo;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class StateListController {
    @Autowired
    private StateRepository stateRepository;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String listStates() {
        return "states";
    }

    @RequestMapping(value = "/api/states", method = RequestMethod.GET)
    @ResponseBody
    public String listStatesJson(ModelMap model) throws JSONException {

        setupFakeStateRepo();

        List<State> states = stateRepository.findAll();

        JSONArray stateListJson = new JSONArray();

        for (State state : states) {
            JSONObject stateJSON = new JSONObject();
            stateJSON.put("name", state.getName());
            stateJSON.put("region", state.getRegion());
            stateListJson.put(stateJSON);
        }

        return stateListJson.toString();
    }

    private void setupFakeStateRepo() {

        State maine = new State( "ME", "Northeast" );
        stateRepository.save(maine);

        State california = new State( "CA", "West" );
        stateRepository.save(california);

    }

}