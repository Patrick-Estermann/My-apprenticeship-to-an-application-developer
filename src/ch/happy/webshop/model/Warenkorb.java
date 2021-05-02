package ch.happy.webshop.model;

import java.util.ArrayList;

public class Warenkorb{
	private Integer artikelSessionId;
	private Integer warenkorbId;
	private String bezeichnung;
	private Integer anzahl;
	private Double preis;
	
	private ArrayList<Warenkorb> warenkorb = new ArrayList<Warenkorb>();

	public Warenkorb(Integer id, String bezeichnung, Integer anzahl, Double preis) {
		this.warenkorbId = id;
		this.bezeichnung = bezeichnung;
		this.anzahl = anzahl;
		this.preis = preis;
	}
	
	public Warenkorb() {
		
	}
	
	
	public Integer getWarenkorbId() {
		return warenkorbId;
	}

	public void setWarenkorbId(Integer warenkorbId) {
		this.warenkorbId = warenkorbId;
	}

	public String getBezeichnung() {
		return bezeichnung;
	}

	public void setBezeichnung(String bezeichnung) {
		this.bezeichnung = bezeichnung;
	}

	public Integer getAnzahl() {
		return anzahl;
	}

	public void setAnzahl(Integer anzahl) {
		this.anzahl = anzahl;
	}

	public Double getPreis() {
		return preis;
	}

	public void setPreis(Double preis) {
		this.preis = preis;
	}

	public ArrayList<Warenkorb> getWarenkorb() {
		return warenkorb;
	}

	public void setWarenkorb(ArrayList<Warenkorb> warenkorb) {
		this.warenkorb = warenkorb;
	}

	public Integer getArtikelSessionId() {
		return artikelSessionId;
	}

	public void setArtikelSessionId(Integer artikelSessionId) {
		this.artikelSessionId = artikelSessionId;
	}
	
	

}
