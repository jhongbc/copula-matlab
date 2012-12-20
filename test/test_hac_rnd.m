%#ok<*DEFNU>
%#ok<*STOUT>

function test_suite = test_hac_rnd
initTestSuite;

function testFlatHacClaytonRnd
    U = hac.rnd('clayton', {1, 2, 3, 4, 5 1.5}, 1000);
    assertInRange(U, 0, 1);
    X = csvread('data/test_copula_rnd_clayton.csv');    
    H = mvkstest2(U, X);
    assertEqual(sum(H(:,1)), 0);
   
function testFlatHacGumbelRndAgainstMatlab
    U = hac.rnd('gumbel', {1 2 1.5}, 1000);
    assertInRange(U, 0, 1);
    X = copularnd('gumbel', 1.5, 1000);
    H = mvkstest2(U, X);
    assertEqual(sum(H(:,1)), 0);

function testFlatHacFrankRnd
    U = hac.rnd('frank', {1 2 3 4 5 1.5}, 1000);
    assertInRange(U, 0, 1);
    X = csvread('data/test_copula_rnd_frank.csv');    
    H = mvkstest2(U, X);
    assertEqual(sum(H(:,1)), 0); 
    
function testHacGumbel3DRnd
    U = hac.rnd('gumbel', {1, {2, 3, 2.0}  1.25}, 1000);
    assertInRange(U, 0, 1);
    X = csvread('data/test_hac_rnd_gumbel3d.csv');    
    H = mvkstest2(U, X);
    assertEqual(sum(H(:,1)), 0);
    
function testHacFrank3DRndWithAlphaMoreThan1
    U = hac.rnd('frank', {1, {2, 3, 2.0}  1.25}, 1000);
    assertInRange(U, 0, 1);
    X = csvread('data/test_hac_rnd_frank3d_1.csv');    
    H = mvkstest2(U, X);
    assertEqual(sum(H(:,1)), 0);
    
function testHacFrank3DRndWithAlphaLessThan1
    U = hac.rnd('frank', {1, {2, 3, 0.75}  0.5}, 1000);
    assertInRange(U, 0, 1);
    X = csvread('data/test_hac_rnd_frank3d_2.csv');    
    H = mvkstest2(U, X);
    assertEqual(sum(H(:,1)), 0);
  
function testHacClayton3DRnd
    U = hac.rnd('clayton', {1, {2, 3, 2.0}  1.25}, 1000);
    assertInRange(U, 0, 1);
    X = csvread('data/test_hac_rnd_clayton3d.csv');    
    H = mvkstest2(U, X);
    assertEqual(sum(H(:,1)), 0);
    
function testHacGumbel7DRnd
    U = hac.rnd('gumbel', {{1, 2, 1.3}, {3, 4, {5, 6, 7 2.2} 1.4}, 1.15}, 1000);
    assertInRange(U, 0, 1);
    X = csvread('data/test_hac_rnd_gumbel7d.csv');    
    H = mvkstest2(U, X);
    assertEqual(sum(H(:,1)), 0);
    
function testHacFrank7DRndWithAlphaMoreThan1
    U = hac.rnd('frank', {{1, 2, 1.3}, {3, 4, {5, 6, 7 2.2} 1.4}, 1.15}, 1000);
    assertInRange(U, 0, 1);
    X = csvread('data/test_hac_rnd_frank7d.csv');    
    H = mvkstest2(U, X);
    assertEqual(sum(H(:,1)), 0);
    
function testHacClayton7DRnd
    U = hac.rnd('clayton', {{1, 2, 1.3}, {3, 4, {5, 6, 7 2.2} 1.4}, 1.15}, 1000);
    assertInRange(U, 0, 1);
    X = csvread('data/test_hac_rnd_clayton7d.csv');    
    H = mvkstest2(U, X);
    assertEqual(sum(H(:,1)), 0);
    
function assertInRange( X, x1, x2 )
    assertEqual(sum(sum(X < x1)), 0);
    assertEqual(sum(sum(X > x2)), 0);

function [ H ] = mvkstest2(X, Y)    
    assert(size(X, 2) == size(Y, 2), 'Dimensions do not match.');
    
    d = size(X, 2);
    H = zeros(d, 2);
    for i=1:d
        [h p] = kstest2(X(:,i), Y(:,i), 0.01);
        H(i,:) = [h p];
    end
    
    