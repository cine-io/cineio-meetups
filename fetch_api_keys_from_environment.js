function fetchFromPivotal(){
  var
    vcap_services = JSON.parse(process.env.VCAP_SERVICES)
    , credentials = vcap_services['cine-io'][0].credentials
  ;
  return {
    publicKey: credentials.publicKey,
    secretKey: credentials.secretKey
  };
}

var fetchFromHeroku = function(){
  return {
    publicKey: process.env.CINE_IO_PUBLIC_KEY,
    secretKey: process.env.CINE_IO_SECRET_KEY
  };
}

module.exports = function(){
  vcap_services = process.env.VCAP_SERVICES
  if (process.env.VCAP_SERVICES){
    return fetchFromPivotal();
  }else if (process.env.CINE_IO_PUBLIC_KEY && process.env.CINE_IO_SECRET_KEY){
    return fetchFromHeroku();
  }else{
    return {publicKey: undefined, secretKey: undefined};
  }
}
