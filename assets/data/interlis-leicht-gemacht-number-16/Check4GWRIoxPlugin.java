package org.catais.ilivalidator.ext;

import ch.ehi.basics.logging.EhiLogger;
import ch.ehi.basics.settings.Settings;
import ch.interlis.ili2c.metamodel.NumericType;
import ch.interlis.ili2c.metamodel.TransferDescription;
import ch.interlis.iom.IomObject;
import ch.interlis.iox.IoxValidationConfig;
import ch.interlis.iox_j.logging.LogEventFactory;
import ch.interlis.iox_j.validator.InterlisFunction;
import ch.interlis.iox_j.validator.ObjectPool;
import ch.interlis.iox_j.validator.Value;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Check4GWRIoxPlugin implements InterlisFunction {
    @Override
    public void init(TransferDescription td, Settings settings, IoxValidationConfig validationConfig, ObjectPool objectPool, LogEventFactory logEventFactory) {
            logger = logEventFactory;
    }

    @Override
    public Value evaluate(String validationKind, String usageScope, IomObject mainObj, Value[] args) {
        if (args[0].skipEvaluation()) {
            return args[0];
        }
        if (args[0].isUndefined()) {
            return Value.createSkipEvaluation();
        }
        String egidString = args[0].getValue();

        // OMG: SSLHandshakeExceptions all over.
        // Do not use HTTPS!
        CloseableHttpClient httpClient = HttpClients.createDefault();

        try {
            HttpGet getRequest = new HttpGet(
                    "http://api3.geo.admin.ch/rest/services/api/MapServer/find?layer=ch.bfs.gebaeude_wohnungs_register&searchText="
                            + egidString +"&searchField=egid&returnGeometry=false&contains=false");
            getRequest.addHeader("accept", "application/json");

            HttpResponse response = httpClient.execute(getRequest);

            if (response.getStatusLine().getStatusCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + response.getStatusLine().getStatusCode());
            }

            BufferedReader br = new BufferedReader(
                    new InputStreamReader((response.getEntity().getContent())));

            String output;
            String jsonString = "";
            while ((output = br.readLine()) != null) {
                jsonString += output;
            }

            JSONObject jsonObject = new JSONObject(jsonString);
            JSONArray resultsArray = jsonObject.getJSONArray("results");

            if (resultsArray.length() == 1) {
                return new Value(true);
            } else {
                return new Value(false);
            }

        } catch (IOException e) {
            logger.addEvent(logger.logErrorMsg(e.getMessage()));
            return new Value(false);
        }
        return new Value(true);
    }

    @Override
    public String getQualifiedIliName() {
        return "SO_FunctionsExt.check4GWR";
    }
}
