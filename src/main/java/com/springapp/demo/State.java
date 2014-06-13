package com.springapp.demo;

import javax.persistence.*;

@Entity(name = "state")
public class State {

    @Id
    private String name;

    private String region;

    public State() {}
    public State(String name, String region) {
        this.name = name;
        this.region = region;
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getRegion() { return region; }
    public void setRegion(String region) { this.region = region; }
}
