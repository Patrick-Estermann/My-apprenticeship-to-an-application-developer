package ch.happy.webshop.model;

import java.util.ArrayList;

public class Inhalt {
	private Integer inhaltId;
	private String bezeichnung;
	private Double preis;
	private String iconPath;
	private ArrayList<Inhalt> inhalt = new ArrayList<Inhalt>();
	
	public Integer getInhaltId() {
		return inhaltId;
	}

	public void setInhaltId(Integer inhaltId) {
		this.inhaltId = inhaltId;
	}

	public String getBezeichnung() {
		return bezeichnung;
	}

	public void setBezeichnung(String bezeichnung) {
		this.bezeichnung = bezeichnung;
	}

	public Double getPreis() {
		return preis;
	}

	public void setPreis(Double preis) {
		this.preis = preis;
	}
	
	public String getIconPath() {
		return iconPath;
	}

	public void setIconPath(String iconPath) {
		this.iconPath = iconPath;
	}
	
	public ArrayList<Inhalt> getInhalt() {
		return inhalt;
	}
	
	public void setInhalt(ArrayList<Inhalt> inhalt) {
		this.inhalt = inhalt;
	}
	
}
