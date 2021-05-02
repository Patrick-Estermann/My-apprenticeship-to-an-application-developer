package ch.happy.webshop.model;

import java.util.ArrayList;

public class Artikel {
	private Integer artikelId;
	private String bezeichnung;
	private Double preis;
	private String iconPath;
	
	private ArrayList<Artikel> artikel = new ArrayList<Artikel>();

	public ArrayList<Artikel> getArtikel() {
		return artikel;
	}

	public void setArtikel(ArrayList<Artikel> artikel) {
		this.artikel = artikel;
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

	public Integer getArtikelId() {
		return artikelId;
	}

	public void setArtikelId(Integer artikelId) {
		this.artikelId = artikelId;
	}
	
	public void setIcon(String iconPath) {
		this.iconPath = iconPath;
	}
	
	public String getIcon() {
		return iconPath;
	}
	
	
}
