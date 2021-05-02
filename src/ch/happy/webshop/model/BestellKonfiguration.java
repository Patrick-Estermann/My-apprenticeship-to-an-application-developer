package ch.happy.webshop.model;

import java.util.ArrayList;

public class BestellKonfiguration {
	private Integer bestellPosId;
	private Integer inhaltId;
	
	private ArrayList<BestellKonfiguration> bestellKonfiguration = new ArrayList<BestellKonfiguration>();
	
	public BestellKonfiguration(Integer bestellPosId, Integer inhaltId) {
		this.bestellPosId = bestellPosId;
		this.inhaltId = inhaltId;
	}
	
	public BestellKonfiguration() {
		
	}
	
	public Integer getInhaltId() {
		return inhaltId;
	}
	public void setInhaltId(Integer inhaltId) {
		this.inhaltId = inhaltId;
	}
	public Integer getBestellPosId() {
		return bestellPosId;
	}
	public void setBestellPosId(Integer bestellPosId) {
		this.bestellPosId = bestellPosId;
	}
	public ArrayList<BestellKonfiguration> getBestellKonfiguration() {
		return bestellKonfiguration;
	}
	public void setBestellKonfiguration(ArrayList<BestellKonfiguration> bestellKonfiguration) {
		this.bestellKonfiguration = bestellKonfiguration;
	}
}
