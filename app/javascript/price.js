// //価格フィールドに価格（半角数字）を入れたら販売手数料と販売利益が自動計算されて表示される。
function priceCalculation(){
  // 価格フィールド、販売手数料・販売利益表示箇所を取得する
  let priceInputField = document.getElementById("item-price");
  let salesFee = document.getElementById("add-tax-price");
  let salesProfit = document.getElementById("profit");

  // 価格フィールドに入力したとき
  priceInputField.addEventListener("input", function(){
    // 入力するごとの値を取得
    let priceValue = document.getElementById("item-price").value;
    // 販売手数料10%計算
    let feeResult = Math.floor(priceValue * 0.1);
    // 販売利益計算
    let profitResult = Math.floor(priceValue - feeResult);
    // 計算した販売手数料・販売利益表示
    salesFee.innerHTML = feeResult.toLocaleString();
    salesProfit.innerHTML = profitResult.toLocaleString();
  });
};

priceCalculation()

window.addEventListener('turbo:load', priceCalculation)