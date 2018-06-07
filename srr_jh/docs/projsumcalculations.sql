SELECT        dbo.tProject_Info.ProjectID, dbo.tProject_Info.ProjectTitle, SUM(dbo.tChangeOrders.CoAmount + dbo.tProject_Info.ContractAwardAmount) AS TCC, 
                         SUM(dbo.vzrptProjectLaborCostByDept.CostPreDesign + dbo.vzrptProjectLaborCostByDept.CostDesign + dbo.vzrptProjectLaborCostByDept.CostRow + dbo.vzrptProjectLaborCostByDept.CostBidAward + dbo.vzrptProjectLaborCostByDept.CostConst
                          + dbo.vCAO3.SumOfDesignAmount) AS BCD, 
                         SUM(dbo.vzrptProjectLaborCostByDept.CostPreDesign + dbo.vzrptProjectLaborCostByDept.CostDesign + dbo.vzrptProjectLaborCostByDept.CostRow + dbo.vzrptProjectLaborCostByDept.CostBidAward + dbo.vzrptProjectLaborCostByDept.CostConst
                          + dbo.vCAO3.SumOfDesignAmount) / SUM(dbo.tChangeOrders.CoAmount + dbo.tProject_Info.ContractAwardAmount) * 100 AS BCDperc, 
                         SUM(dbo.vzrptProjectLaborCostByDept.CostPreDesign + dbo.vzrptProjectLaborCostByDept.CostDesign + dbo.vzrptProjectLaborCostByDept.CostRow + dbo.vzrptProjectLaborCostByDept.CostBidAward + dbo.vzrptProjectLaborCostByDept.CostConst
                          + dbo.vCAO6.SumOfCtcmAmount) AS BCC, 
                         SUM(dbo.vzrptProjectLaborCostByDept.CostPreDesign + dbo.vzrptProjectLaborCostByDept.CostDesign + dbo.vzrptProjectLaborCostByDept.CostRow + dbo.vzrptProjectLaborCostByDept.CostBidAward + dbo.vzrptProjectLaborCostByDept.CostConst
                          + dbo.vCAO6.SumOfCtcmAmount) / SUM(dbo.tChangeOrders.CoAmount + dbo.tProject_Info.ContractAwardAmount) * 100 AS BCCperc, 
                         SUM(dbo.vCAO1.SumOfPreDesignAmount + dbo.vCAO2.SumOfRowAmount + dbo.vCAO3.SumOfDesignAmount + dbo.vCAO4.SumOfCtpAmount + dbo.vCAO5.SumOfConsAmount + dbo.vCAO6.SumOfCtcmAmount) 
                         AS CTC, dbo.vCoTotals.CoTotalAmount
FROM            dbo.vzrptProjectLaborCostByDept INNER JOIN
                         dbo.tChangeOrders ON dbo.vzrptProjectLaborCostByDept.ProjectID = dbo.tChangeOrders.ProjectID INNER JOIN
                         dbo.tProject_Info ON dbo.tChangeOrders.ProjectID = dbo.tProject_Info.ProjectID INNER JOIN
                         dbo.vCAO5 ON dbo.tChangeOrders.ProjectID = dbo.vCAO5.ProjectID INNER JOIN
                         dbo.vCAO6 ON dbo.tChangeOrders.ProjectID = dbo.vCAO6.ProjectID INNER JOIN
                         dbo.vCAO3 ON dbo.tChangeOrders.ProjectID = dbo.vCAO3.ProjectID INNER JOIN
                         dbo.vCAO1 ON dbo.tChangeOrders.ProjectID = dbo.vCAO1.ProjectID INNER JOIN
                         dbo.vCAO2 ON dbo.tChangeOrders.ProjectID = dbo.vCAO2.ProjectID INNER JOIN
                         dbo.vCAO4 ON dbo.tChangeOrders.ProjectID = dbo.vCAO4.ProjectID INNER JOIN
                         dbo.vCoTotals ON dbo.tChangeOrders.ProjectID = dbo.vCoTotals.ProjectID
GROUP BY dbo.tProject_Info.ProjectID, dbo.tProject_Info.ProjectTitle, dbo.vzrptProjectLaborCostByDept.Dept, dbo.vCoTotals.CoTotalAmount, dbo.vCAO6.SumOfCtcmAmount, dbo.vCAO3.SumOfDesignAmount, 
                         dbo.vCAO5.SumOfConsAmount
HAVING        (dbo.vzrptProjectLaborCostByDept.Dept = '78')