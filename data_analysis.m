%data = csvread('data-test2.csv', 1, 1);
data = csvread('data_40-50-60-80-wVolume.csv', 1, 2);

%Remove Outliers
data([11 41 29],:) = [];

T = data(:,2);
Xi = data(:,3);
Xf = data(:,4);
Ai = data(:,5);
Af = data(:,6);
ti = data(:,8);
tf = data(:,9);
Vsolid = data(:,16);
Vwater = data(:,17);
Xg = data(:,19);
Pabove = data(:,22);
Pbelow = data(:,23);
LL0 = data(:,24);
LinfL0 = data(:,25);
LLinfL0Linf = data(:,26);

%T = (T-mean(T))/std(T);
%Vsolid = (Vsolid-mean(Vsolid))/std(Vsolid);
%Vwater = (Vwater-mean(Vwater))/std(Vwater);
%tf = (tf-mean(tf))/std(tf);
Vsolid = -1*Vsolid;
Vwater = -1*Vwater;

% Full model
y = Af./Ai;
X = [T, T.^2, Xi, Xi.^2, Xf, Xf.^2, ti, ti.^2, tf, tf.^2];
sf = regstats(y, X, 'linear', 'all');
[b, bint] = regress(y, [ones(length(T), 1), X]);

fprintf('\n\nFull Model\t R^2 = %g\n', sf.rsquare);
fprintf('Intercept\tb\tbint-\tbint+\tp-value\n');
fprintf('Constant \t%.4g\t%.4g\t%.4g\t%g\n', b(1), bint(1,1), bint(1,2), sf.tstat.pval(1));
fprintf('T        \t%.4g\t%.4g\t%.4g\t%g\n', b(2), bint(2,1), bint(2,2), sf.tstat.pval(2));
fprintf('T^2      \t%.4g\t%.4g\t%.4g\t%g\n', b(3), bint(3,1), bint(3,2), sf.tstat.pval(3));
fprintf('Xi       \t%.4g\t%.4g\t%.4g\t%g\n', b(4), bint(4,1), bint(4,2), sf.tstat.pval(4));
fprintf('Xi^2     \t%.4g\t%.4g\t%.4g\t%g\n', b(5), bint(5,1), bint(5,2), sf.tstat.pval(5));
fprintf('Xf       \t%.4g\t%.4g\t%.4g\t%g\n', b(6), bint(6,1), bint(6,2), sf.tstat.pval(6));
fprintf('Xf^2     \t%.4g\t%.4g\t%.4g\t%g\n', b(7), bint(7,1), bint(7,2), sf.tstat.pval(7));
fprintf('ti       \t%.4g\t%.4g\t%.4g\t%g\n', b(8), bint(8,1), bint(8,2), sf.tstat.pval(8));
fprintf('ti^2     \t%.4g\t%.4g\t%.4g\t%g\n', b(9), bint(9,1), bint(9,2), sf.tstat.pval(9));
fprintf('tf       \t%.4g\t%.4g\t%.4g\t%g\n', b(10), bint(10,1), bint(10,2), sf.tstat.pval(10));
fprintf('tf^2     \t%.4g\t%.4g\t%.4g\t%g\n', b(11), bint(11,1), bint(11,2), sf.tstat.pval(11));

% Reduced model
y = sqrt(Af./Ai);
X = [T, T.^2, Xf-Xi, (Xf-Xi).^2, tf];
sr = regstats(y, X, 'linear', 'all');
[b, bint] = regress(y, [ones(length(T), 1), X]);

fprintf('\nReduced Model\t R^2 = %g\n', sr.rsquare);
fprintf('Intercept\tb\tbint-\tbint+\tp-value\n');
fprintf('Constant \t%.4g\t%.4g\t%.4g\t%.4g\n', b(1), bint(1,1), bint(1,2), sr.tstat.pval(1));
fprintf('T        \t%.4g\t%.4g\t%.4g\t%g\n', b(2), bint(2,1), bint(2,2), sr.tstat.pval(2));
fprintf('T^2      \t%.4g\t%.4g\t%.4g\t%g\n', b(3), bint(3,1), bint(3,2), sr.tstat.pval(3));
fprintf('Xf-Xi    \t%.4g\t%.4g\t%.4g\t%g\n', b(4), bint(4,1), bint(4,2), sr.tstat.pval(4));
fprintf('(Xf-Xi)^2\t%.4g\t%.4g\t%.4g\t%g\n', b(5), bint(5,1), bint(5,2), sr.tstat.pval(5));
fprintf('tf       \t%.4g\t%.4g\t%.4g\t%g\n', b(6), bint(6,1), bint(6,2), sr.tstat.pval(6));
%fprintf('Xg       \t%.4g\t%.4g\t%.4g\t%g\n', b(7), bint(7,1), bint(7,2), sr.tstat.pval(7));

% Tg
y = sqrt(Af./Ai);
X = [T, T.^2, Xg, tf, Xf];
sg = regstats(y, X, 'linear', 'all');
[b, bint] = regress(y, [ones(length(T), 1), X]);

fprintf('\nTg Model\t R^2 = %g\n', sr.rsquare);
fprintf('Intercept\tb\tbint-\tbint+\tp-value\n');
fprintf('Constant \t%.4g\t%.4g\t%.4g\t%.4g\n', b(1), bint(1,1), bint(1,2), sg.tstat.pval(1));
fprintf('T        \t%.4g\t%.4g\t%.4g\t%g\n', b(2), bint(2,1), bint(2,2), sg.tstat.pval(2));
fprintf('T^2      \t%.4g\t%.4g\t%.4g\t%g\n', b(3), bint(3,1), bint(3,2), sg.tstat.pval(3));
fprintf('Above    \t%.4g\t%.4g\t%.4g\t%g\n', b(4), bint(4,1), bint(4,2), sg.tstat.pval(4));
fprintf('tf       \t%.4g\t%.4g\t%.4g\t%g\n', b(5), bint(5,1), bint(5,2), sg.tstat.pval(5));
fprintf('Xf       \t%.4g\t%.4g\t%.4g\t%g\n', b(6), bint(6,1), bint(6,2), sg.tstat.pval(6));

%plot(Pabove, sqrt(Af./Ai)-b(2)*T-b(3)*T.^2-b(5)*tf, '.')

% Linear Temperature model
y = sqrt(Af./Ai);
X = [T, Xf-Xi, (Xf-Xi).^2, tf];
sr = regstats(y, X, 'linear', 'all');
[b, bint] = regress(y, [ones(length(T), 1), X]);

fprintf('\nLinear Temperature Model\t R^2 = %g\n', sr.rsquare);
fprintf('Intercept\tb\tbint-\tbint+\tp-value\n');
fprintf('Constant \t%.4g\t%.4g\t%.4g\t%.4g\n', b(1), bint(1,1), bint(1,2), sr.tstat.pval(1));
fprintf('T        \t%.4g\t%.4g\t%.4g\t%g\n', b(2), bint(2,1), bint(2,2), sr.tstat.pval(2));
fprintf('Xf-Xi      \t%.4g\t%.4g\t%.4g\t%g\n', b(3), bint(3,1), bint(3,2), sr.tstat.pval(3));
fprintf('(Xf-Xi)^2    \t%.4g\t%.4g\t%.4g\t%g\n', b(4), bint(4,1), bint(4,2), sr.tstat.pval(4));
fprintf('tf\t%.4g\t%.4g\t%.4g\t%g\n', b(5), bint(5,1), bint(5,2), sr.tstat.pval(5));

% Linear model
y = sqrt(Af./Ai);
X = [T, Xf-Xi, tf];
sr = regstats(y, X, 'linear', 'all');
[b, bint] = regress(y, [ones(length(T), 1), X]);

fprintf('\nLinear Model\t R^2 = %g\n', sr.rsquare);
fprintf('Intercept\tb\tbint-\tbint+\tp-value\n');
fprintf('Constant \t%.4g\t%.4g\t%.4g\t%.4g\n', b(1), bint(1,1), bint(1,2), sr.tstat.pval(1));
fprintf('T        \t%.4g\t%.4g\t%.4g\t%g\n', b(2), bint(2,1), bint(2,2), sr.tstat.pval(2));
fprintf('Xf-Xi      \t%.4g\t%.4g\t%.4g\t%g\n', b(3), bint(3,1), bint(3,2), sr.tstat.pval(3));
fprintf('tf\t%.4g\t%.4g\t%.4g\t%g\n', b(4), bint(4,1), bint(4,2), sr.tstat.pval(4));

% Volume Model
y = Vsolid;
X = [Vwater, Vwater.^2, tf];
sv = regstats(y, X, 'linear', 'all');
[b, bint] = regress(y, [ones(length(T), 1), X]);

fprintf('\nVolume Model\t R^2 = %g\n', sv.rsquare);
fprintf('Intercept\tb\tbint-\tbint+\tp-value\n');
fprintf('Constant \t%.4g\t%.4g\t%.4g\t%.4g\n', b(1), bint(1,1), bint(1,2), sv.tstat.pval(1));
%fprintf('T^2        \t%.4g\t%.4g\t%.4g\t%g\n', b(2), bint(2,1), bint(2,2), sv.tstat.pval(2));
fprintf('Vwater      \t%.4g\t%.4g\t%.4g\t%g\n', b(2), bint(2,1), bint(2,2), sv.tstat.pval(2));
fprintf('Vwater^2    \t%.4g\t%.4g\t%.4g\t%g\n', b(3), bint(3,1), bint(3,2), sv.tstat.pval(3));
fprintf('tf       \t%.4g\t%.4g\t%.4g\t%g\n', b(4), bint(4,1), bint(4,2), sv.tstat.pval(4));
%fprintf('tf       \t%.4g\t%.4g\t%.4g\t%g\n', b(6), bint(6,1), bint(6,2), sr.tstat.pval(6));

% Porosity
y = LLinfL0Linf;
X = [T, Xf, tf];
sv = regstats(y, X, 'linear', 'all');
[b, bint] = regress(y, [ones(length(T), 1), X]);

fprintf('\nPorosity Model\t R^2 = %g\n', sv.rsquare);
fprintf('Intercept\tb\tbint-\tbint+\tp-value\n');
fprintf('Constant \t%.4g\t%.4g\t%.4g\t%.4g\n', b(1), bint(1,1), bint(1,2), sv.tstat.pval(1));
fprintf('T      \t%.4g\t%.4g\t%.4g\t%g\n', b(2), bint(2,1), bint(2,2), sv.tstat.pval(2));
fprintf('Xf    \t%.4g\t%.4g\t%.4g\t%g\n', b(3), bint(3,1), bint(3,2), sv.tstat.pval(3));
fprintf('tf       \t%.4g\t%.4g\t%.4g\t%g\n', b(4), bint(4,1), bint(4,2), sv.tstat.pval(4));
